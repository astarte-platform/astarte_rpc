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

defmodule Astarte.RPC.Config do
  @moduledoc """
  This module helps the access to the runtime configuration of Astarte RPC
  """

  @doc """
  Returns the amqp_connection options or an empty list if they're not set.
  """
  def amqp_options do
    Application.get_env(:astarte_rpc, :amqp_connection, [])
  end

  @doc """
  Returns the amqp prefetch count. Defaults to 300.
  """
  def amqp_prefetch_count do
    Application.get_env(:astarte_rpc, :amqp_prefetch_count, 300)
  end

  def amqp_queue_arguments do
    max_length = Application.get_env(:astarte_rpc, :amqp_queue_max_length)

    if is_integer(max_length) and max_length > 0 do
      [{:"x-max-length", max_length}, {:"x-overflow", "reject-publish"}]
    else
      []
    end
  end
end
