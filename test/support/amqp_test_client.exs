defmodule Astarte.RPC.AMQPTestClient do
  @test_queue "test_server_rpc"

  alias Astarte.RPC.AMQP.Client

  def start_link do
    Client.start_link()
  end

  def eval_code_call(str_code) do
    Client.rpc_call("call:" <> str_code, @test_queue)
  end

  def eval_code_cast(str_code) do
    Client.rpc_cast("cast:" <> str_code, @test_queue)
  end
end
