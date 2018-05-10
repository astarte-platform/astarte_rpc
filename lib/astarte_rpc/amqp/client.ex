#
# Copyright (C) 2018 Ispirata Srl
#
# This file is part of Astarte.
# Astarte is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Astarte is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with Astarte.  If not, see <http://www.gnu.org/licenses/>.
#

defmodule Astarte.RPC.AMQP.Client do
  require Logger
  use GenServer
  alias Astarte.RPC.Config

  @connection_backoff 10000

  @behaviour Astarte.RPC.Client

  # API

  def start_link(args \\ []) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def rpc_call(ser_payload, destination, timeout \\ 5000) when is_binary(ser_payload) do
    GenServer.call(__MODULE__, {:rpc, ser_payload, destination}, timeout)
  end

  def rpc_cast(ser_payload, destination) when is_binary(ser_payload) do
    GenServer.cast(__MODULE__, {:rpc, ser_payload, destination})
  end

  # Callbacks

  def init(opts) do
    prefix = Keyword.get(opts, :amqp_prefix, "astarte_")
    send(self(), :try_to_connect)

    {:ok,
     %{
       channel: nil,
       reply_queue: nil,
       pending_reqs: %{},
       prefix: prefix
     }}
  end

  def terminate(_reason, %AMQP.Channel{conn: conn} = chan) do
    AMQP.Channel.close(chan)
    AMQP.Connection.close(conn)
  end

  def handle_call({:rpc, _ser_payload, _routing_key}, _from, %{channel: nil} = state) do
    {:reply, {:error, :retry}, state}
  end

  def handle_call({:rpc, ser_payload, routing_key}, from, state) do
    %{
      channel: chan,
      reply_queue: reply_queue,
      pending_reqs: pending,
      prefix: prefix
    } = state

    correlation_id = gen_correlation_id()
    prefixed_routing_key = prefix <> routing_key

    AMQP.Basic.publish(
      chan,
      "",
      prefixed_routing_key,
      ser_payload,
      reply_to: reply_queue,
      correlation_id: correlation_id
    )

    new_pending = Map.put(pending, correlation_id, from)

    {:noreply, %{state | pending_reqs: new_pending}}
  end

  def handle_cast({:rpc, ser_payload, _routing_key}, %{channel: nil} = state) do
    Logger.warn("RPC cast while not connected: #{inspect(ser_payload)}")
    {:noreply, state}
  end

  def handle_cast({:rpc, ser_payload, routing_key}, state) do
    %{
      channel: chan,
      prefix: prefix
    } = state

    prefixed_routing_key = prefix <> routing_key

    AMQP.Basic.publish(chan, "", prefixed_routing_key, ser_payload)
    {:noreply, state}
  end

  def handle_info(:try_to_connect, state) do
    {:ok, connection_state} = connect()
    {:noreply, Map.merge(state, connection_state)}
  end

  # This callback should try to reconnect to the server
  def handle_info({:DOWN, _, :process, _pid, _reason}, state) do
    Logger.warn("RabbitMQ connection lost. Trying to reconnect...")

    # Reply to the pending requests with a temporary error
    Enum.each(state.pending_reqs, fn _corr_id, caller ->
      GenServer.reply(caller, {:error, :retry})
    end)

    new_state = %{state | pending_reqs: %{}}

    {:ok, connection_state} = connect()
    {:noreply, Map.merge(new_state, connection_state)}
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

  def handle_info(
        {:basic_deliver, ser_reply, %{correlation_id: deliver_correlation_id}},
        %{pending_reqs: pending} = state
      ) do
    Map.get(pending, deliver_correlation_id)
    |> maybe_reply(ser_reply)

    {:noreply, %{state | pending_reqs: Map.delete(pending, deliver_correlation_id)}}
  end

  defp connect do
    with {:ok, conn} <- AMQP.Connection.open(Config.amqp_options()),
         {:ok, chan} <- AMQP.Channel.open(conn),
         :ok <- AMQP.Basic.qos(chan, prefetch_count: Config.amqp_prefetch_count()),
         {:ok, %{queue: reply_queue}} <-
           AMQP.Queue.declare(chan, "", exclusive: true, auto_delete: true),
         {:ok, _consumer_tag} <- AMQP.Basic.consume(chan, reply_queue, self(), no_ack: true),
         # Get notifications when the chan or conn go down
         Process.monitor(chan.pid) do
      {:ok, %{channel: chan, reply_queue: reply_queue}}
    else
      {:error, reason} ->
        Logger.warn("RabbitMQ Connection error: " <> inspect(reason))
        retry_connection_after(@connection_backoff)
        {:ok, %{channel: nil, reply_queue: nil}}

      :error ->
        Logger.warn("Unknown RabbitMQ connection error")
        retry_connection_after(@connection_backoff)
        {:ok, %{channel: nil, reply_queue: nil}}
    end
  end

  defp gen_correlation_id do
    :crypto.strong_rand_bytes(16)
    |> Base.encode64(padding: false)
  end

  defp maybe_reply(nil, _reply) do
    :ok
  end

  defp maybe_reply(caller, "error:" <> reply) do
    GenServer.reply(caller, {:error, reply})
  end

  defp maybe_reply(caller, ok_reply) do
    GenServer.reply(caller, {:ok, ok_reply})
  end

  defp retry_connection_after(backoff) do
    Logger.warn("Retrying connection in #{backoff} ms")
    Process.send_after(self(), :try_to_connect, backoff)
  end
end
