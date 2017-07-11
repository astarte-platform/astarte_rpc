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
      @rpc_queue unquote(rpc_queue)

      def start_link do
        GenServer.start_link(__MODULE__, [], name: unquote(name))
      end

      def init(_opts) do
        {:ok, state} = rabbitmq_connect(false)
      end

      def rpc_call(ser_payload, timeout \\ 5000) do
        GenServer.call(unquote(name), {:rpc, ser_payload}, timeout)
      end

      def rpc_cast(ser_payload) do
        GenServer.cast(unquote(name), {:rpc, ser_payload})
      end

      defp rabbitmq_connect(retry \\ true) do
        with {:ok, conn} <- AMQP.Connection.open(unquote(amqp_options)),
             # Get notifications when the connection goes down
             Process.monitor(conn.pid),
             {:ok, chan} <- AMQP.Channel.open(conn),
             {:ok, %{queue: reply_queue}} <- AMQP.Queue.declare(chan, "", exclusive: true, auto_delete: true),
             {:ok, _consumer_tag} <- AMQP.Basic.consume(chan, reply_queue, self(), no_ack: true) do

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

      # Confirmation sent by the broker after registering this process as a consumer
      def handle_info({:basic_consume_ok, %{consumer_tag: _consumer_tag}}, state) do
        {:noreply, state}
      end

      # Sent by the broker when the consumer is unexpectedly cancelled (such as after a queue deletion)
      def handle_info({:basic_cancel, %{consumer_tag: _consumer_tag}}, state) do
        {:stop, :normal, state}
      end

      # Confirmation sent by the broker to the consumer process after a Basic.cancel
      def handle_info({:basic_cancel_ok, %{consumer_tag: _consumer_tag}}, state) do
        {:noreply, state}
      end

      def handle_info({:basic_deliver, ser_reply, %{correlation_id: deliver_correlation_id}}, %{pending_reqs: pending} = state) do
        Map.get(pending, deliver_correlation_id)
        |> maybe_reply(ser_reply)

        {:noreply, %{state | pending_reqs: Map.delete(pending, deliver_correlation_id)}}
      end

      def maybe_reply(nil, _reply) do
        :ok
      end

      def maybe_reply(caller, "error:" <> reply) do
        GenServer.reply(caller, {:error, reply})
      end

      def maybe_reply(caller, ok_reply) do
        GenServer.reply(caller, {:ok, ok_reply})
      end

      def handle_call({:rpc, ser_payload}, from, state) when is_binary(ser_payload) do
        %{channel: chan,
          reply_queue: reply_queue,
          correlation_id: correlation_id,
          pending_reqs: pending} = state

        correlation_id_str = Integer.to_string(correlation_id)

        AMQP.Basic.publish(chan,
                           "",
                           @rpc_queue,
                           ser_payload,
                           reply_to: reply_queue,
                           correlation_id: correlation_id_str)

        {:noreply, %{channel: chan,
                     reply_queue: reply_queue,
                     correlation_id: correlation_id + 1,
                     pending_reqs: Map.put(pending, correlation_id_str, from)}}

      end

      def handle_call({:rpc, _not_ser_payload}, _from, state) do
        Logger.warn("rpc must be called with an encoded payload")
        {:reply, :error, state}
      end


      def handle_cast({:rpc, ser_payload}, %{channel: chan} = state) when is_binary(ser_payload) do
        AMQP.Basic.publish(chan,
                           "",
                           @rpc_queue,
                           ser_payload)
        {:noreply, state}
      end

      def handle_cast({:rpc, _not_ser_payload}, state) do
        Logger.warn("rpc must be called with an encoded payload")
        {:noreply, state}
      end

    end # quote
  end # defmacro

end
