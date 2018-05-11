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

defmodule Astarte.RPC.Client do
  @moduledoc """
  This module defines the Astarte RPC Client behaviour.

  Its responsibility is delivering the serialized request to the RPC server and delivering
  the serialized reply to the caller (if needed).
  """
  @callback rpc_call(serialized_request :: binary(), destination :: term()) ::
              {:ok, serialized_reply :: binary()}
              | {:error, reason :: term()}
  @callback rpc_call(
              serialized_request :: binary(),
              destination :: term(),
              timeout :: integer()
            ) ::
              {:ok, serialized_reply :: binary()}
              | {:error, reason :: term()}

  @callback rpc_cast(serialized_request :: binary(), destination :: term()) :: :ok
end
