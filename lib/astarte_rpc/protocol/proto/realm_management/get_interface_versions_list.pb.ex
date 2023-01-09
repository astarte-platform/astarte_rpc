defmodule Astarte.RPC.Protocol.RealmManagement.GetInterfaceVersionsList do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetInterfaceVersionsList"

  field :realm_name, 1, proto3_optional: true, type: :string, json_name: "realmName"
  field :interface_name, 2, proto3_optional: true, type: :string, json_name: "interfaceName"
end
