defmodule Astarte.RPC.Protocol.Pairing.GetAgentPublicKeyPEMsReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetAgentPublicKeyPEMsReply"

  field :agent_public_key_pems, 1, repeated: true, type: :string, json_name: "agentPublicKeyPems"
end
