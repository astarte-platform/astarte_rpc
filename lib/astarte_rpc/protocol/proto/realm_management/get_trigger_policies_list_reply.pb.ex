defmodule Astarte.RPC.Protocol.RealmManagement.GetTriggerPoliciesListReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetTriggerPoliciesListReply"

  field :trigger_policies_names, 1,
    repeated: true,
    type: :string,
    json_name: "triggerPoliciesNames"
end
