defmodule Astarte.RPC.Protocol.Housekeeping.GenericOkReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GenericOkReply"

  field :async_operation, 1, type: :bool, json_name: "asyncOperation"
end
