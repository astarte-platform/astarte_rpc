defmodule Astarte.RPC.Protocol.VMQ.Plugin.Disconnect do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "Disconnect"

  field :client_id, 1, proto3_optional: true, type: :string, json_name: "clientId"
  field :discard_state, 2, type: :bool, json_name: "discardState"
end
