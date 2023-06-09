defmodule Astarte.RPC.Protocol.DataUpdaterPlant.Call do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "Call"

  oneof :call, 0

  field :version, 1, type: :int32, deprecated: true

  field :install_volatile_trigger, 2,
    type: Astarte.RPC.Protocol.DataUpdaterPlant.InstallVolatileTrigger,
    json_name: "installVolatileTrigger",
    oneof: 0

  field :delete_volatile_trigger, 3,
    type: Astarte.RPC.Protocol.DataUpdaterPlant.DeleteVolatileTrigger,
    json_name: "deleteVolatileTrigger",
    oneof: 0
end
