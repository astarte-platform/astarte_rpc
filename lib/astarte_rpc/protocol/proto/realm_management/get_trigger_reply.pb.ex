defmodule Astarte.RPC.Protocol.RealmManagement.GetTriggerReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetTriggerReply"

  field :trigger_data, 1, proto3_optional: true, type: :bytes, json_name: "triggerData"

  field :serialized_tagged_simple_triggers, 2,
    repeated: true,
    type: :bytes,
    json_name: "serializedTaggedSimpleTriggers"
end
