defmodule Astarte.RPC.Protocol.Pairing.AstarteMQTTV1Credentials do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "AstarteMQTTV1Credentials"

  field :client_crt, 1, proto3_optional: true, type: :string, json_name: "clientCrt"
end
