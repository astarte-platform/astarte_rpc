defmodule Astarte.RPC.Protocol.RealmManagement.GetDatastreamMaximumStorageRetention do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :realm_name, 1, proto3_optional: true, type: :string, json_name: "realmName"
end
