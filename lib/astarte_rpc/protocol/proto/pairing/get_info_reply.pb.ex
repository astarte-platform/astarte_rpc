defmodule Astarte.RPC.Protocol.Pairing.GetInfoReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetInfoReply"

  field :version, 1, proto3_optional: true, type: :string
  field :device_status, 2, proto3_optional: true, type: :string, json_name: "deviceStatus"
  field :protocols, 3, repeated: true, type: Astarte.RPC.Protocol.Pairing.ProtocolStatus
end
