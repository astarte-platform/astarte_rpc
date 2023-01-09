defmodule Astarte.RPC.Protocol.RealmManagement.InstallInterface do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "InstallInterface"

  field :realm_name, 1, proto3_optional: true, type: :string, json_name: "realmName"
  field :interface_json, 2, proto3_optional: true, type: :string, json_name: "interfaceJson"
  field :async_operation, 3, type: :bool, json_name: "asyncOperation"
end
