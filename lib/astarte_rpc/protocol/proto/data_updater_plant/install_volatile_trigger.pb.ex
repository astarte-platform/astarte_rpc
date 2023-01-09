defmodule Astarte.RPC.Protocol.DataUpdaterPlant.InstallVolatileTrigger do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "InstallVolatileTrigger"

  field :realm_name, 1, proto3_optional: true, type: :string, json_name: "realmName"
  field :device_id, 2, proto3_optional: true, type: :string, json_name: "deviceId"
  field :object_id, 3, proto3_optional: true, type: :bytes, json_name: "objectId"
  field :object_type, 4, type: :int32, json_name: "objectType"
  field :parent_id, 5, proto3_optional: true, type: :bytes, json_name: "parentId"
  field :simple_trigger_id, 8, proto3_optional: true, type: :bytes, json_name: "simpleTriggerId"
  field :simple_trigger, 6, proto3_optional: true, type: :bytes, json_name: "simpleTrigger"
  field :trigger_target, 7, proto3_optional: true, type: :bytes, json_name: "triggerTarget"
end
