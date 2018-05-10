defmodule Astarte.RPC.AMQPTestEvalServer do
  @test_queue "test_server_rpc"

  @moduledoc """
  A simple AMQP RPC test server. It receives strings beginning with `cast:` or `call:`
  and it evals the rest of the string. It replies with a string representation of the
  result if it's a `call` or it just prints the result if it's a `cast`.
  """

  alias Astarte.RPC.AMQP.Server

  @behaviour Astarte.RPC.Handler

  def start_link do
    Server.start_link(amqp_queue: @test_queue, handler: __MODULE__)
  end

  def handle_rpc("cast:" <> payload) do
    {value, _bindings} = Code.eval_string(payload)
    IO.puts("#{value}")
    :ok
  end

  def handle_rpc("call:invalid") do
    {:error, "custom error reason"}
  end

  def handle_rpc("call:" <> payload) do
    {value, _bindings} = Code.eval_string(payload)
    {:ok, to_string(value)}
  end
end
