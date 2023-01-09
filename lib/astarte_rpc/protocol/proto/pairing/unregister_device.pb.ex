defmodule Astarte.RPC.Protocol.Pairing.UnregisterDevice do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "UnregisterDevice"

  field :realm, 1, proto3_optional: true, type: :string
  field :device_id, 2, proto3_optional: true, type: :string, json_name: "deviceId"
end
