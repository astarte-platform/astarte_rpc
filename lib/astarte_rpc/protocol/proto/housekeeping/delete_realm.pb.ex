defmodule Astarte.RPC.Protocol.Housekeeping.DeleteRealm do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "DeleteRealm"

  field :realm, 1, proto3_optional: true, type: :string
  field :async_operation, 2, type: :bool, json_name: "asyncOperation"
end
