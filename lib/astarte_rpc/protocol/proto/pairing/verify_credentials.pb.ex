defmodule Astarte.RPC.Protocol.Pairing.VerifyCredentials do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "VerifyCredentials"

  oneof :credentials, 0

  field :realm, 1, proto3_optional: true, type: :string
  field :hw_id, 2, proto3_optional: true, type: :string, json_name: "hwId"
  field :secret, 3, proto3_optional: true, type: :string

  field :astarte_mqtt_v1, 4,
    type: Astarte.RPC.Protocol.Pairing.AstarteMQTTV1Credentials,
    json_name: "astarteMqttV1",
    oneof: 0
end
