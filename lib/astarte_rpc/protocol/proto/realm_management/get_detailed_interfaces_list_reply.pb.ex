defmodule Astarte.RPC.Protocol.RealmManagement.GetDetailedInterfacesListReply do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :interface_json, 1, repeated: true, type: :string, json_name: "interfaceJson"
end
