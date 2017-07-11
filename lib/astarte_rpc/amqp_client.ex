defmodule Astarte.RPC.AMQPClient do

  defmacro __using__(opts) do
    target_module = __CALLER__.module

    rpc_queue = Keyword.fetch!(opts, :rpc_queue)
    amqp_options = Keyword.get(opts, :amqp_options, [])
    name = Keyword.get(opts, :name, target_module)

    quote location: :keep do
      require Logger
      use GenServer

      @connection_backoff 10000

      def start_link do
        GenServer.start_link(__MODULE__, [], name: unquote(name))
      end

      def init(_opts) do
        {:ok, state} = rabbitmq_connect(false)
      end

      defp rabbitmq_connect(retry \\ true) do
        with {:ok, conn} <- AMQP.Connection.open(unquote(amqp_options)),
             # Get notifications when the connection goes down
             Process.monitor(conn.pid),
             {:ok, chan} <- AMQP.Channel.open(conn),
             {:ok, %{queue: reply_queue}} <- AMQP.Queue.declare(chan, "", exclusive: true, auto_delete: true) do

          {:ok, %{channel: chan,
                  reply_queue: reply_queue,
                  correlation_id: 0,
                  pending_reqs: %{}}}

        else
          {:error, reason} ->
            Logger.warn("RabbitMQ Connection error: " <> inspect(reason))
            maybe_retry(retry)
          :error ->
            Logger.warn("Unknown RabbitMQ connection error")
            maybe_retry(retry)
        end
      end

      defp maybe_retry(retry) do
        if retry do
          Logger.warn("Retrying connection in #{@connection_backoff} ms")
          :erlang.send_after(@connection_backoff, :erlang.self(), {:try_to_connect})
          {:ok, :not_connected}
        else
          {:stop, :connection_failed}
        end
      end

      # Server callbacks

      def handle_info({:try_to_connect}, state) do
        {:ok, new_state} = rabbitmq_connect()
        {:noreply, new_state}
      end


      # This callback should try to reconnect to the server
      def handle_info({:DOWN, _, :process, _pid, _reason}, _state) do
        Logger.warn("RabbitMQ connection lost. Trying to reconnect...")
        {:ok, new_state} = rabbitmq_connect()
        {:noreply, new_state}
      end

    end # quote
  end # defmacro

end
