defmodule Astarte.RPC.Protocol.RealmManagement.GetTriggersListReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetTriggersListReply"

  field :triggers_names, 1, repeated: true, type: :string, json_name: "triggersNames"
end
