defmodule Astarte.RPC.Protocol.Housekeeping.ReplicationClass do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "ReplicationClass"

  field :SIMPLE_STRATEGY, 0
  field :NETWORK_TOPOLOGY_STRATEGY, 1
end
