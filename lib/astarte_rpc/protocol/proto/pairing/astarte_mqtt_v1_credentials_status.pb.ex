defmodule Astarte.RPC.Protocol.Pairing.AstarteMQTTV1CredentialsStatus do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "AstarteMQTTV1CredentialsStatus"

  field :valid, 1, type: :bool
  field :timestamp, 2, type: :int64
  field :until, 3, type: :int64
  field :cause, 4, type: Astarte.RPC.Protocol.Pairing.CertificateValidationError, enum: true
  field :details, 5, proto3_optional: true, type: :string
end
