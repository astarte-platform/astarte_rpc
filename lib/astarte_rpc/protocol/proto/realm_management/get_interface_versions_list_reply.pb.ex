defmodule Astarte.RPC.Protocol.RealmManagement.GetInterfaceVersionsListReplyVersionTuple do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetInterfaceVersionsListReplyVersionTuple"

  field :major_version, 1, type: :int32, json_name: "majorVersion"
  field :minor_version, 2, type: :int32, json_name: "minorVersion"
end

defmodule Astarte.RPC.Protocol.RealmManagement.GetInterfaceVersionsListReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetInterfaceVersionsListReply"

  field :versions, 1,
    repeated: true,
    type: Astarte.RPC.Protocol.RealmManagement.GetInterfaceVersionsListReplyVersionTuple
end
