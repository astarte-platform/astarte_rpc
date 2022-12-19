defmodule Astarte.RPC.Protocol.Pairing.RegisterDeviceReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "RegisterDeviceReply"

  field :credentials_secret, 1,
    proto3_optional: true,
    type: :string,
    json_name: "credentialsSecret"
end
