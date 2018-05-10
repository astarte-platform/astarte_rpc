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
