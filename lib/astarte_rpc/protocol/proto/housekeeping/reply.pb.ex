defmodule Astarte.RPC.Protocol.Housekeeping.Reply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "Reply"

  oneof :reply, 0

  field :version, 1, type: :int32, deprecated: true
  field :error, 2, type: :bool

  field :generic_ok_reply, 5,
    type: Astarte.RPC.Protocol.Housekeeping.GenericOkReply,
    json_name: "genericOkReply",
    oneof: 0

  field :generic_error_reply, 3,
    type: Astarte.RPC.Protocol.Housekeeping.GenericErrorReply,
    json_name: "genericErrorReply",
    oneof: 0

  field :does_realm_exist_reply, 4,
    type: Astarte.RPC.Protocol.Housekeeping.DoesRealmExistReply,
    json_name: "doesRealmExistReply",
    oneof: 0

  field :get_realms_list_reply, 6,
    type: Astarte.RPC.Protocol.Housekeeping.GetRealmsListReply,
    json_name: "getRealmsListReply",
    oneof: 0

  field :get_realm_reply, 7,
    type: Astarte.RPC.Protocol.Housekeeping.GetRealmReply,
    json_name: "getRealmReply",
    oneof: 0

  field :get_health_reply, 8,
    type: Astarte.RPC.Protocol.Housekeeping.GetHealthReply,
    json_name: "getHealthReply",
    oneof: 0
end
