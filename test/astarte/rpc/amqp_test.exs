#
# This file is part of Astarte.
#
# Copyright 2017 Ispirata Srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

defmodule Astarte.RPC.AMQPTest do
  use ExUnit.Case

  @test_queue "test_server_rpc"

  setup_all do
    amqp_options = Application.get_env(:astarte_rpc, :amqp_connection, [])
    {:ok, conn} = AMQP.Connection.open(amqp_options)
    {:ok, chan} = AMQP.Channel.open(conn)
    AMQP.Queue.declare(chan, @test_queue)
    Astarte.RPC.AMQPTestEvalServer.start_link()
    Astarte.RPC.AMQPTestClient.start_link()
    # Wait for async connection
    :timer.sleep(1000)
    :ok
  end

  test "synchronous call" do
    assert Astarte.RPC.AMQPTestClient.eval_code_call("1 + 1") == {:ok, "2"}
  end

  test "exception call" do
    assert Astarte.RPC.AMQPTestClient.eval_code_call("1 + 1 asd") == {:error, "exception"}
  end

  test "custom errors" do
    assert Astarte.RPC.AMQPTestClient.eval_code_call("invalid") == {:error, "custom error reason"}
  end
end
