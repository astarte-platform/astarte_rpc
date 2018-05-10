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

defmodule Astarte.RPC.Handler do
  @moduledoc """
  This module defines the Astarte RPC Handler behaviour.

  This must be implemented by modules that will be called from RPC Server.
  """
  @callback handle_rpc(payload :: binary) ::
    :ok |
    {:ok, reply :: term} |
    {:error, :retry} |
    {:error, reason :: term}
end
