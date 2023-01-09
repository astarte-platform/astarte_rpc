defmodule Astarte.RPC.Protocol.RealmManagement.GetInterfaceSource do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetInterfaceSource"

  field :realm_name, 1, proto3_optional: true, type: :string, json_name: "realmName"
  field :interface_name, 2, proto3_optional: true, type: :string, json_name: "interfaceName"
  field :interface_major_version, 3, type: :int32, json_name: "interfaceMajorVersion"
end
