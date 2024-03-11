defmodule Astarte.RPC.Protocol.RealmManagement.GetDatastreamMaximumStorageRetentionReply do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :datastream_maximum_storage_retention, 1,
    type: :int64,
    json_name: "datatreamMaximumStorageRetention"
end
