defmodule Astarte.RPC.Protocol.Housekeeping.Call do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "Call"

  oneof :call, 0

  field :version, 1, type: :int32, deprecated: true

  field :create_realm, 2,
    type: Astarte.RPC.Protocol.Housekeeping.CreateRealm,
    json_name: "createRealm",
    oneof: 0

  field :does_realm_exist, 3,
    type: Astarte.RPC.Protocol.Housekeeping.DoesRealmExist,
    json_name: "doesRealmExist",
    oneof: 0

  field :get_realms_list, 4,
    type: Astarte.RPC.Protocol.Housekeeping.GetRealmsList,
    json_name: "getRealmsList",
    oneof: 0

  field :get_realm, 5,
    type: Astarte.RPC.Protocol.Housekeeping.GetRealm,
    json_name: "getRealm",
    oneof: 0

  field :get_health, 6,
    type: Astarte.RPC.Protocol.Housekeeping.GetHealth,
    json_name: "getHealth",
    oneof: 0

  field :delete_realm, 7,
    type: Astarte.RPC.Protocol.Housekeeping.DeleteRealm,
    json_name: "deleteRealm",
    oneof: 0

  field :update_realm, 8,
    type: Astarte.RPC.Protocol.Housekeeping.UpdateRealm,
    json_name: "updateRealm",
    oneof: 0
end
