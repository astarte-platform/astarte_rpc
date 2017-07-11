defmodule Astarte.RPC.AMQPTestClient do
  @test_queue "test_server_rpc"

  use Astarte.RPC.AMQPClient,
    rpc_queue: @test_queue,
    amqp_options: Application.get_env(:astarte_rpc, :amqp_connection, [])

  def eval_code_call(str_code) do
    rpc_call("call:" <> str_code)
  end

  def eval_code_cast(str_code) do
    rpc_cast("cast:" <> str_code)
  end
end
