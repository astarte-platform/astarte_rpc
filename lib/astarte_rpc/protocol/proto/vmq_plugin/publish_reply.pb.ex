defmodule Astarte.RPC.Protocol.VMQ.Plugin.PublishReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "PublishReply"

  field :local_matches, 1, type: :int32, json_name: "localMatches"
  field :remote_matches, 2, type: :int32, json_name: "remoteMatches"
end
