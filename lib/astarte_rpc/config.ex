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

  use Skogsra

  @envdoc "Username for accessing the AMQP broker."
  app_env :amqp_connection_username, :astarte_rpc, :amqp_connection_username,
    os_env: "RPC_AMQP_CONNECTION_USERNAME",
    type: :binary,
    default: "guest"

  @envdoc "Password for accessing the AMQP broker."
  app_env :amqp_connection_password, :astarte_rpc, :amqp_connection_password,
    os_env: "RPC_AMQP_CONNECTION_PASSWORD",
    type: :binary,
    default: "guest"

  @envdoc "The hostname or IP of the AMQP broker."
  app_env :amqp_connection_host, :astarte_rpc, :amqp_connection_host,
    os_env: "RPC_AMQP_CONNECTION_HOST",
    type: :binary,
    default: "localhost"

  @envdoc "The Virtual Host to be used in the AMQP broker. Must be the same for all components."
  app_env :amqp_connection_virtual_host, :astarte_rpc, :amqp_connection_virtual_host,
    os_env: "RPC_AMQP_CONNECTION_VIRTUAL_HOST",
    type: :binary,
    default: "/"

  @envdoc "The port of the AMQP broker to connect to."
  app_env :amqp_connection_port, :astarte_rpc, :amqp_connection_port,
    os_env: "RPC_AMQP_CONNECTION_PORT",
    type: :integer,
    default: 5672

  @envdoc "The prefetch count of the AMQP connection. A prefetch count of 0 means unlimited (not recommended)."
  app_env :amqp_prefetch_count, :astarte_rpc, :amqp_prefetch_count,
    os_env: "RPC_AMQP_PREFETCH_COUNT",
    type: :integer,
    default: 300,
    required: true

  @envdoc """
  Max length of the server AMQP queue. If 0 the queue will be unbounded, otherwise it will be limited to tha    t length and new publishes will be dropped while the queue is full. WARNING: changing this value requires manually     deleting the queue
  """
  app_env :amqp_queue_max_length, :astarte_rpc, :amqp_queue_max_length,
    os_env: "RPC_AMQP_QUEUE_MAX_LENGTH",
    type: :integer,
    default: 0

  @doc "The AMQP queue arguments."
  @type argument :: {:"x-max-length", integer()} | {:"x-overflow", String.t()}
  @spec amqp_queue_arguments!() :: [argument]
  def amqp_queue_arguments! do
    value = amqp_queue_max_length!()

    if value > 0 do
      ["x-max-length": value, "x-overflow": "reject-publish"]
    else
      []
    end
  end

  @doc """
  Returns the amqp_connection options or an empty list if they're not set.
  """
  @type options ::
          {:username, String.t()}
          | {:password, String.t()}
          | {:virtual_host, String.t()}
          | {:host, String.t()}
          | {:port, integer()}

  @spec amqp_options!() :: [options]
  def amqp_options! do
    username = amqp_connection_username!()
    password = amqp_connection_password!()
    virtual_host = amqp_connection_virtual_host!()
    host = amqp_connection_host!()
    port = amqp_connection_port!()

    [
      username: username,
      password: password,
      virtual_host: virtual_host,
      host: host,
      port: port
    ]
  end
end
