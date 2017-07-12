defmodule Astarte.RPC.Protocol.Housekeeping do
  @external_resource Path.expand("proto/housekeeping", __DIR__)

  use Protobuf, from: Path.wildcard(Path.expand("proto/housekeeping/*.proto", __DIR__))
  use Astarte.RPC.Protocol
end
