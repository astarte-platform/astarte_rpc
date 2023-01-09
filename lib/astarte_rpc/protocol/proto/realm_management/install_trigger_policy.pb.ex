defmodule Astarte.RPC.Protocol.RealmManagement.InstallTriggerPolicy do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "InstallTriggerPolicy"

  field :realm_name, 1, proto3_optional: true, type: :string, json_name: "realmName"

  field :trigger_policy_json, 2,
    proto3_optional: true,
    type: :string,
    json_name: "triggerPolicyJson"

  field :async_operation, 3, type: :bool, json_name: "asyncOperation"
end
