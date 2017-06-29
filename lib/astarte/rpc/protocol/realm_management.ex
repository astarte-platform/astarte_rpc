defmodule Astarte.RPC.Protocol.RealmManagement do
  @external_resource Path.expand("../../proto/realm_management", __DIR__)

  use Protobuf, from: Path.wildcard(Path.expand("../../proto/realm_management/*.proto", __DIR__))
end
