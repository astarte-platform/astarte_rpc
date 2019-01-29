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
