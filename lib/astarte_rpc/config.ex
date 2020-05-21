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

  @envdoc "Enable SSL. If not specified, SSL is disabled."
  app_env :amqp_connection_ssl_enabled, :astarte_rpc, :amqp_connection_ssl_enabled,
    os_env: "RPC_AMQP_CONNECTION_SSL_ENABLED",
    type: :boolean,
    default: false

  @envdoc "Disable Server Name Indication. Defaults to false."
  app_env :amqp_connection_ssl_disable_sni,
          :astarte_rpc,
          :amqp_connection_ssl_disable_sni,
          os_env: "RPC_AMQP_CONNECTION_SSL_DISABLE_SNI",
          type: :boolean,
          default: false

  @envdoc "Specify the hostname to be used in TLS Server Name Indication extension. If not specified, the amqp host will be used. This value is used only if Server Name Indication is enabled."
  app_env :amqp_connection_ssl_custom_sni,
          :astarte_appengine_api,
          :amqp_connection_ssl_custom_sni,
          os_env: "RPC_AMQP_CONNECTION_SSL_CUSTOM_SNI",
          type: :binary

  @envdoc "Specifies the certificates of the root Certificate Authorities to be trusted. When not specified, the bundled cURL certificate bundle will be used."
  app_env :amqp_connection_ssl_ca_file, :astarte_rpc, :amqp_connection_ssl_ca_file,
    os_env: "RPC_AMQP_CONNECTION_SSL_CA_FILE",
    type: :binary

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
  @type ssl_option ::
          {:cacertfile, String.t()}
          | {:verify, :verify_peer}
          | {:server_name_indication, :disable | charlist()}
          | {:depth, integer()}
  @type ssl_options :: :none | [ssl_option]

  @type options ::
          {:username, String.t()}
          | {:password, String.t()}
          | {:virtual_host, String.t()}
          | {:host, String.t()}
          | {:port, integer()}
          | {:ssl_options, ssl_options}

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
    |> populate_ssl_options()
  end

  defp populate_ssl_options(options) do
    if amqp_connection_ssl_enabled!() do
      ssl_options = build_ssl_options()
      Keyword.put(options, :ssl_options, ssl_options)
    else
      options
    end
  end

  defp build_ssl_options() do
    [
      cacertfile: amqp_connection_ssl_ca_file!() || CAStore.file_path(),
      verify: :verify_peer,
      depth: 10
    ]
    |> populate_sni()
  end

  defp populate_sni(ssl_options) do
    if amqp_connection_ssl_disable_sni!() do
      Keyword.put(ssl_options, :server_name_indication, :disable)
    else
      server_name = amqp_connection_ssl_custom_sni!() || amqp_connection_host!()
      Keyword.put(ssl_options, :server_name_indication, to_charlist(server_name))
    end
  end
end
