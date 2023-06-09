defmodule Astarte.RPC.Protocol.Housekeeping.DoesRealmExist do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "DoesRealmExist"

  field :realm, 1, proto3_optional: true, type: :string
end
