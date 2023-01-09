defmodule Astarte.RPC.Protocol.Pairing.RegisterDevice do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "RegisterDevice"

  field :hw_id, 1, proto3_optional: true, type: :string, json_name: "hwId"
  field :realm, 2, proto3_optional: true, type: :string

  field :initial_introspection, 3,
    repeated: true,
    type: Astarte.RPC.Protocol.Pairing.IntrospectionEntry,
    json_name: "initialIntrospection"
end
