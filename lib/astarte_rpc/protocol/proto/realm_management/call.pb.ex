defmodule Astarte.RPC.Protocol.RealmManagement.Call do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "Call"

  oneof :call, 0

  field :version, 1, type: :int32, deprecated: true

  field :install_interface, 2,
    type: Astarte.RPC.Protocol.RealmManagement.InstallInterface,
    json_name: "installInterface",
    oneof: 0

  field :update_interface, 6,
    type: Astarte.RPC.Protocol.RealmManagement.UpdateInterface,
    json_name: "updateInterface",
    oneof: 0

  field :delete_interface, 7,
    type: Astarte.RPC.Protocol.RealmManagement.DeleteInterface,
    json_name: "deleteInterface",
    oneof: 0

  field :get_interface_source, 3,
    type: Astarte.RPC.Protocol.RealmManagement.GetInterfaceSource,
    json_name: "getInterfaceSource",
    oneof: 0

  field :get_interface_versions_list, 4,
    type: Astarte.RPC.Protocol.RealmManagement.GetInterfaceVersionsList,
    json_name: "getInterfaceVersionsList",
    oneof: 0

  field :get_interfaces_list, 5,
    type: Astarte.RPC.Protocol.RealmManagement.GetInterfacesList,
    json_name: "getInterfacesList",
    oneof: 0

  field :get_jwt_public_key_pem, 8,
    type: Astarte.RPC.Protocol.RealmManagement.GetJWTPublicKeyPEM,
    json_name: "getJwtPublicKeyPem",
    oneof: 0

  field :update_jwt_public_key_pem, 9,
    type: Astarte.RPC.Protocol.RealmManagement.UpdateJWTPublicKeyPEM,
    json_name: "updateJwtPublicKeyPem",
    oneof: 0

  field :install_trigger, 10,
    type: Astarte.RPC.Protocol.RealmManagement.InstallTrigger,
    json_name: "installTrigger",
    oneof: 0

  field :get_trigger, 11,
    type: Astarte.RPC.Protocol.RealmManagement.GetTrigger,
    json_name: "getTrigger",
    oneof: 0

  field :get_triggers_list, 12,
    type: Astarte.RPC.Protocol.RealmManagement.GetTriggersList,
    json_name: "getTriggersList",
    oneof: 0

  field :delete_trigger, 13,
    type: Astarte.RPC.Protocol.RealmManagement.DeleteTrigger,
    json_name: "deleteTrigger",
    oneof: 0

  field :get_health, 14,
    type: Astarte.RPC.Protocol.RealmManagement.GetHealth,
    json_name: "getHealth",
    oneof: 0

  field :install_trigger_policy, 15,
    type: Astarte.RPC.Protocol.RealmManagement.InstallTriggerPolicy,
    json_name: "installTriggerPolicy",
    oneof: 0

  field :delete_trigger_policy, 16,
    type: Astarte.RPC.Protocol.RealmManagement.DeleteTriggerPolicy,
    json_name: "deleteTriggerPolicy",
    oneof: 0

  field :get_trigger_policies_list, 17,
    type: Astarte.RPC.Protocol.RealmManagement.GetTriggerPoliciesList,
    json_name: "getTriggerPoliciesList",
    oneof: 0

  field :get_trigger_policy_source, 18,
    type: Astarte.RPC.Protocol.RealmManagement.GetTriggerPolicySource,
    json_name: "getTriggerPolicySource",
    oneof: 0

  field :delete_device, 19,
    type: Astarte.RPC.Protocol.RealmManagement.DeleteDevice,
    json_name: "deleteDevice",
    oneof: 0
end
