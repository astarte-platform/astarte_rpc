defmodule Astarte.RPC.Protocol.Pairing.GetCredentials do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetCredentials"

  oneof :credentials_parameters, 0

  field :hw_id, 1, proto3_optional: true, type: :string, json_name: "hwId"
  field :realm, 2, proto3_optional: true, type: :string
  field :secret, 3, proto3_optional: true, type: :string
  field :device_ip, 4, proto3_optional: true, type: :string, json_name: "deviceIp"

  field :astarte_mqtt_v1, 5,
    type: Astarte.RPC.Protocol.Pairing.AstarteMQTTV1CredentialsParameters,
    json_name: "astarteMqttV1",
    oneof: 0
end
