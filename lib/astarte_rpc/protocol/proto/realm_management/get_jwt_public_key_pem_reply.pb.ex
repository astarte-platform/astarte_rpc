defmodule Astarte.RPC.Protocol.RealmManagement.GetJWTPublicKeyPEMReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetJWTPublicKeyPEMReply"

  field :jwt_public_key_pem, 1, proto3_optional: true, type: :string, json_name: "jwtPublicKeyPem"
end
