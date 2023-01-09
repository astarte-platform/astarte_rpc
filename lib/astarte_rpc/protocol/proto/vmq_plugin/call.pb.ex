defmodule Astarte.RPC.Protocol.VMQ.Plugin.Call do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "Call"

  oneof :call, 0

  field :version, 1, type: :int32, deprecated: true
  field :disconnect, 3, type: Astarte.RPC.Protocol.VMQ.Plugin.Disconnect, oneof: 0
  field :publish, 2, type: Astarte.RPC.Protocol.VMQ.Plugin.Publish, oneof: 0
end
