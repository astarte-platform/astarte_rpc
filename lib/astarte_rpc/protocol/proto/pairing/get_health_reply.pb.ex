defmodule Astarte.RPC.Protocol.Pairing.GetHealthReply.Status do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetHealthReply.Status"

  field :INVALID, 0
  field :READY, 1
  field :DEGRADED, 2
  field :BAD, 3
  field :ERROR, 4
end

defmodule Astarte.RPC.Protocol.Pairing.GetHealthReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetHealthReply"

  field :status, 1, type: Astarte.RPC.Protocol.Pairing.GetHealthReply.Status, enum: true
end
