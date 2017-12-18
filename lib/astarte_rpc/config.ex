#
# This file is part of Astarte.
#
# Astarte is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Astarte is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Astarte.  If not, see <http://www.gnu.org/licenses/>.
#
# Copyright (C) 2017 Ispirata Srl
#

defmodule Astarte.RPC.Config do
  @moduledoc """
  This module helps the access to the runtime configuration of Astarte RPC
  """

  @doc """
  Returns the amqp_queue contained in the config.

  Raises if it doesn't exist since it's required.
  """
  def amqp_queue! do
    Application.fetch_env!(:astarte_rpc, :amqp_queue)
  end

  @doc """
  Returns the amqp_connection options or an empty list if they're not set.
  """
  def amqp_options do
    Application.get_env(:astarte_rpc, :amqp_connection, [])
  end
end
