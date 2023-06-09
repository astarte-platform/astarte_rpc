defmodule Astarte.RPC.Protocol.Pairing.IntrospectionEntry do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "IntrospectionEntry"

  field :interface_name, 1, proto3_optional: true, type: :string, json_name: "interfaceName"
  field :major_version, 2, type: :int32, json_name: "majorVersion"
  field :minor_version, 3, type: :int32, json_name: "minorVersion"
end
