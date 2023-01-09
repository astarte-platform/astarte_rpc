defmodule Astarte.RPC.Protocol.RealmManagement.GetHealth do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetHealth"
end
