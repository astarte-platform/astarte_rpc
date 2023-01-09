defmodule Astarte.RPC.Protocol.RealmManagement.GetTriggerPolicySourceReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetTriggerPolicySourceReply"

  field :source, 1, proto3_optional: true, type: :string
end
