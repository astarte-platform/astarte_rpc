defmodule Astarte.RPC.Protocol.RealmManagement.Reply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "Reply"

  oneof :reply, 0

  field :version, 1, type: :int32, deprecated: true
  field :error, 2, type: :bool

  field :generic_ok_reply, 7,
    type: Astarte.RPC.Protocol.RealmManagement.GenericOkReply,
    json_name: "genericOkReply",
    oneof: 0

  field :generic_error_reply, 3,
    type: Astarte.RPC.Protocol.RealmManagement.GenericErrorReply,
    json_name: "genericErrorReply",
    oneof: 0

  field :get_interface_source_reply, 4,
    type: Astarte.RPC.Protocol.RealmManagement.GetInterfaceSourceReply,
    json_name: "getInterfaceSourceReply",
    oneof: 0

  field :get_interface_versions_list_reply, 5,
    type: Astarte.RPC.Protocol.RealmManagement.GetInterfaceVersionsListReply,
    json_name: "getInterfaceVersionsListReply",
    oneof: 0

  field :get_interfaces_list_reply, 6,
    type: Astarte.RPC.Protocol.RealmManagement.GetInterfacesListReply,
    json_name: "getInterfacesListReply",
    oneof: 0

  field :get_jwt_public_key_pem_reply, 8,
    type: Astarte.RPC.Protocol.RealmManagement.GetJWTPublicKeyPEMReply,
    json_name: "getJwtPublicKeyPemReply",
    oneof: 0

  field :get_trigger_reply, 9,
    type: Astarte.RPC.Protocol.RealmManagement.GetTriggerReply,
    json_name: "getTriggerReply",
    oneof: 0

  field :get_triggers_list_reply, 10,
    type: Astarte.RPC.Protocol.RealmManagement.GetTriggersListReply,
    json_name: "getTriggersListReply",
    oneof: 0

  field :get_health_reply, 11,
    type: Astarte.RPC.Protocol.RealmManagement.GetHealthReply,
    json_name: "getHealthReply",
    oneof: 0

  field :get_trigger_policies_list_reply, 12,
    type: Astarte.RPC.Protocol.RealmManagement.GetTriggerPoliciesListReply,
    json_name: "getTriggerPoliciesListReply",
    oneof: 0

  field :get_trigger_policy_source_reply, 13,
    type: Astarte.RPC.Protocol.RealmManagement.GetTriggerPolicySourceReply,
    json_name: "getTriggerPolicySourceReply",
    oneof: 0

  field :get_device_registration_limit_reply, 14,
    type: Astarte.RPC.Protocol.RealmManagement.GetDeviceRegistrationLimitReply,
    json_name: "getDeviceRegistrationLimitReply",
    oneof: 0
end
