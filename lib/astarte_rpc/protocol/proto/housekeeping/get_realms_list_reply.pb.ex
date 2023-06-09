defmodule Astarte.RPC.Protocol.Housekeeping.GetRealmsListReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetRealmsListReply"

  field :realms_names, 1, repeated: true, type: :string, json_name: "realmsNames"
end
