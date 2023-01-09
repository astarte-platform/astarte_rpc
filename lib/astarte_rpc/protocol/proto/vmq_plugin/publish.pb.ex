defmodule Astarte.RPC.Protocol.VMQ.Plugin.Publish do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "Publish"

  field :topic_tokens, 1, repeated: true, type: :string, json_name: "topicTokens"
  field :payload, 2, proto3_optional: true, type: :bytes
  field :qos, 3, type: :int32
end
