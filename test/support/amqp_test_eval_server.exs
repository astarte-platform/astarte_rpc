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
