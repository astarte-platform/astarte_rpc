defmodule Astarte.RPC.Protocol.RealmManagement.InstallTrigger do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "InstallTrigger"

  field :realm_name, 1, proto3_optional: true, type: :string, json_name: "realmName"
  field :trigger_name, 2, proto3_optional: true, type: :string, json_name: "triggerName"
  field :action, 3, proto3_optional: true, type: :bytes

  field :serialized_tagged_simple_triggers, 4,
    repeated: true,
    type: :bytes,
    json_name: "serializedTaggedSimpleTriggers"

  field :trigger_policy, 5, proto3_optional: true, type: :string, json_name: "triggerPolicy"
end
