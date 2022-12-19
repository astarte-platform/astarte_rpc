defmodule Astarte.RPC.Protocol.Pairing.Reply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "Reply"

  oneof :reply, 0

  field :version, 1, type: :int32, deprecated: true
  field :error, 2, type: :bool

  field :generic_ok_reply, 3,
    type: Astarte.RPC.Protocol.Pairing.GenericOkReply,
    json_name: "genericOkReply",
    oneof: 0

  field :generic_error_reply, 4,
    type: Astarte.RPC.Protocol.Pairing.GenericErrorReply,
    json_name: "genericErrorReply",
    oneof: 0

  field :get_agent_public_key_pems_reply, 9,
    type: Astarte.RPC.Protocol.Pairing.GetAgentPublicKeyPEMsReply,
    json_name: "getAgentPublicKeyPemsReply",
    oneof: 0

  field :get_credentials_reply, 7,
    type: Astarte.RPC.Protocol.Pairing.GetCredentialsReply,
    json_name: "getCredentialsReply",
    oneof: 0

  field :get_health_reply, 10,
    type: Astarte.RPC.Protocol.Pairing.GetHealthReply,
    json_name: "getHealthReply",
    oneof: 0

  field :get_info_reply, 5,
    type: Astarte.RPC.Protocol.Pairing.GetInfoReply,
    json_name: "getInfoReply",
    oneof: 0

  field :register_device_reply, 6,
    type: Astarte.RPC.Protocol.Pairing.RegisterDeviceReply,
    json_name: "registerDeviceReply",
    oneof: 0

  field :verify_credentials_reply, 8,
    type: Astarte.RPC.Protocol.Pairing.VerifyCredentialsReply,
    json_name: "verifyCredentialsReply",
    oneof: 0
end
