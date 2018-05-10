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

defmodule Astarte.RPC.AMQP.Server do
  @moduledoc """
  An RPC server that consumes an AMQP queue and calls an handler implementing
  the Handler behaviour
  """

  require Logger
  use GenServer
  alias Astarte.RPC.Config

  @connection_backoff 10000

  # API

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  # Callbacks

  def init(opts) do
    handler = Keyword.fetch!(opts, :handler)
    amqp_queue = Keyword.fetch!(opts, :amqp_queue)
    prefix = Keyword.get(opts, :amqp_prefix, "astarte_")

    prefixed_queue = prefix <> amqp_queue

    send(self(), :try_to_connect)
    {:ok, %{channel: nil, handler: handler, queue_name: prefixed_queue}}
  end

  def terminate(_reason, state) do
    if state.channel do
      conn = state.channel.conn
      AMQP.Channel.close(state.channel)
      AMQP.Connection.close(conn)
    end
  end

  def handle_info(:try_to_connect, state) do
    {:ok, connection_state} = connect()
    {:noreply, Map.merge(state, connection_state)}
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

  def handle_info({:basic_deliver, payload, meta}, state) do
    # We process the message asynchronously
    spawn_link(fn -> consume(state.channel, payload, meta) end)
    {:noreply, state}
  end

  # This callback should try to reconnect to the server
  def handle_info({:DOWN, _, :process, _pid, _reason}, state) do
    Logger.warn("RabbitMQ connection lost. Trying to reconnect...")
    {:ok, connection_state} = connect()
    {:noreply, Map.merge(state, connection_state)}
  end

  defp consume(chan, payload, meta) do
    apply_process_rpc(payload)
    |> ack_or_reject(chan, meta.delivery_tag)
    |> maybe_reply(chan, meta.reply_to, meta.correlation_id)
  end

  defp apply_process_rpc(payload) do
    try do
      apply(unquote(target_module), :process_rpc, [payload])
    rescue
      e ->
        Logger.warn("Exception while handling message: #{inspect(e)}")
        {:error, :exception}
    end
  end

  defp ack_or_reject(result = :ok, chan, delivery_tag) do
    AMQP.Basic.ack(chan, delivery_tag)
    result
  end

  defp ack_or_reject(result = {:ok, _reply}, chan, delivery_tag) do
    AMQP.Basic.ack(chan, delivery_tag)
    result
  end

  defp ack_or_reject(result = {:error, :retry}, chan, delivery_tag) do
    AMQP.Basic.reject(chan, delivery_tag, requeue: true)
    Logger.warn("Temporary error, re-enqueing the message")
    result
  end

  defp ack_or_reject(result = {:error, reason}, chan, delivery_tag) do
    AMQP.Basic.reject(chan, delivery_tag, requeue: false)
    Logger.warn("Message rejected with reason #{inspect(reason)}")
    result
  end

  defp connect do
    with {:ok, conn} <- AMQP.Connection.open(Config.amqp_options()),
         {:ok, chan} <- AMQP.Channel.open(conn),
         :ok <- AMQP.Basic.qos(chan, prefetch_count: Config.amqp_prefetch_count()),
         {:ok, _queue} <- AMQP.Queue.declare(chan, Config.amqp_queue!()),
         {:ok, _consumer_tag} <- AMQP.Basic.consume(chan, Config.amqp_queue!()),
         # Get notifications when the chan or conn go down
         Process.monitor(chan.pid) do
      {:ok, %{channel: chan}}
    else
      {:error, reason} ->
        Logger.warn("RabbitMQ Connection error: " <> inspect(reason))
        retry_after(@connection_backoff)
        {:ok, %{channel: nil}}

      :error ->
        Logger.warn("Unknown RabbitMQ connection error")
        retry_after(@connection_backoff)
        {:ok, %{channel: nil}}
    end
  end

  defp retry_after(backoff) do
    Logger.warn("Retrying connection in #{backoff} ms")
    Process.send_after(self(), :try_to_connect, backoff)
  end

  defp maybe_reply(reply, _chan, :undefined, _correlation_id) do
    Logger.warn("Got a reply but no queue to write it to: #{reply}")
  end

  defp maybe_reply({:ok, reply}, chan, reply_to, correlation_id) do
    AMQP.Basic.publish(chan, "", reply_to, reply, correlation_id: correlation_id)
  end

  defp maybe_reply({:error, reason}, chan, reply_to, correlation_id) when is_binary(reason) do
    AMQP.Basic.publish(chan, "", reply_to, "error:" <> reason, correlation_id: correlation_id)
  end

  defp maybe_reply({:error, reason}, chan, reply_to, correlation_id) when is_atom(reason) do
    AMQP.Basic.publish(
      chan,
      "",
      reply_to,
      "error:" <> to_string(reason),
      correlation_id: correlation_id
    )
  end

  defp maybe_reply(_result, _chan, _reply_to, _correlation_id) do
    :ok
  end
end
