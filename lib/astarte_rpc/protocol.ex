#
# Copyright (C) 2017 Ispirata Srl
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
  This is a utility module to inject a `__using__` macro to the
  Astarte.RPC.Protocol modules (e.g. Housekeeping, RealmManagement...).

  To do this just `use Astarte.RPC.Protocol`.

  The generated `__using__` macro makes it possible to do something like
  `use Astarte.RPC.Protocol.Housekeeping` and alias all the messages defined
  under the `Astarte.RPC.Protocol.Housekeeping`.
  """
  defmacro __using__(_opts) do
    inject_autoaliases_macro()
  end

  defp inject_autoaliases_macro() do
    quote unquote: false do
      defmacro __using__(_opts) do
        proto_msgs = __MODULE__.defs()
                     |> Enum.filter(fn elem -> match?({{:msg, _}, _}, elem) end)
                     |> Enum.map(fn _elem = {{:msg, msg}, _} -> msg end)

        Enum.map(proto_msgs, fn msg ->
          quote do
            alias unquote(msg)
          end
        end)
      end
    end
  end
end
