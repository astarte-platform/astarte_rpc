defmodule Astarte.RPC.Protocol.DataUpdaterPlant.Reply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "Reply"

  oneof :reply, 0

  field :version, 1, type: :int32, deprecated: true
  field :error, 2, type: :bool

  field :generic_ok_reply, 3,
    type: Astarte.RPC.Protocol.DataUpdaterPlant.GenericOkReply,
    json_name: "genericOkReply",
    oneof: 0

  field :generic_error_reply, 4,
    type: Astarte.RPC.Protocol.DataUpdaterPlant.GenericErrorReply,
    json_name: "genericErrorReply",
    oneof: 0
end
