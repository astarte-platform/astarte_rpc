defmodule Astarte.RPC.Protocol.Pairing.AstarteMQTTV1CredentialsParameters do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "AstarteMQTTV1CredentialsParameters"

  field :csr, 1, proto3_optional: true, type: :string
end
