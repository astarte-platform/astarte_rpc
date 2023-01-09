defmodule Astarte.RPC.Protocol.Pairing.Call do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "Call"

  oneof :call, 0

  field :version, 1, type: :int32, deprecated: true

  field :get_agent_public_key_pems, 6,
    type: Astarte.RPC.Protocol.Pairing.GetAgentPublicKeyPEMs,
    json_name: "getAgentPublicKeyPems",
    oneof: 0

  field :get_credentials, 4,
    type: Astarte.RPC.Protocol.Pairing.GetCredentials,
    json_name: "getCredentials",
    oneof: 0

  field :get_health, 8,
    type: Astarte.RPC.Protocol.Pairing.GetHealth,
    json_name: "getHealth",
    oneof: 0

  field :get_info, 2, type: Astarte.RPC.Protocol.Pairing.GetInfo, json_name: "getInfo", oneof: 0

  field :register_device, 3,
    type: Astarte.RPC.Protocol.Pairing.RegisterDevice,
    json_name: "registerDevice",
    oneof: 0

  field :verify_credentials, 5,
    type: Astarte.RPC.Protocol.Pairing.VerifyCredentials,
    json_name: "verifyCredentials",
    oneof: 0

  field :unregister_device, 7,
    type: Astarte.RPC.Protocol.Pairing.UnregisterDevice,
    json_name: "unregisterDevice",
    oneof: 0
end
