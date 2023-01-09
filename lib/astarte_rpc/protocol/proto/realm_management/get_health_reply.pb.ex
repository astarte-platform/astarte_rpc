defmodule Astarte.RPC.Protocol.RealmManagement.GetHealthReply.Status do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetHealthReply.Status"

  field :READY, 0
  field :DEGRADED, 1
  field :BAD, 2
  field :ERROR, 3
end

defmodule Astarte.RPC.Protocol.RealmManagement.GetHealthReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetHealthReply"

  field :status, 1, type: Astarte.RPC.Protocol.RealmManagement.GetHealthReply.Status, enum: true
end
