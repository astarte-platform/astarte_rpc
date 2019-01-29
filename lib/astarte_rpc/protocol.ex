#
# This file is part of Astarte.
#
# Copyright 2018 Ispirata Srl
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

defmodule Astarte.RPC.Protocol do
  @moduledoc """
  This is a utility module to inject an amqp_queue function that returns the amqp
  queue for a specific RPC protocol. This is useful to make sure that the client and
  the server are synchronized.
  """
  defmacro __using__(opts) do
    case Keyword.fetch(opts, :amqp_queue) do
      :error ->
        IO.warn("No amqp_queue set in use options", Macro.Env.stacktrace(__ENV__))

      {:ok, queue} ->
        inject_amqp_queue_fun(queue)
    end
  end

  defp inject_amqp_queue_fun(queue) do
    quote do
      def amqp_queue do
        unquote(queue)
      end
    end
  end
end
