defmodule Astarte.RPC.Protocol.Pairing.CertificateValidationError do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "CertificateValidationError"

  field :INVALID, 0
  field :EXPIRED, 1
  field :INVALID_ISSUER, 2
  field :INVALID_SIGNATURE, 3
  field :NAME_NOT_PERMITTED, 4
  field :MISSING_BASIC_CONSTRAINT, 5
  field :INVALID_KEY_USAGE, 6
  field :REVOKED, 7
end
