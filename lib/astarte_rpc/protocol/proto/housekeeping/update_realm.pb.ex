defmodule Astarte.RPC.Protocol.Housekeeping.UpdateRealm.DatacenterReplicationFactorsEntry do
  @moduledoc false

  use Protobuf, map: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "UpdateRealm.DatacenterReplicationFactorsEntry"

  field :key, 1, type: :string
  field :value, 2, type: :int32
end

defmodule Astarte.RPC.Protocol.Housekeeping.UpdateRealm do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "UpdateRealm"

  field :realm, 1, proto3_optional: true, type: :string
  field :jwt_public_key_pem, 3, proto3_optional: true, type: :string, json_name: "jwtPublicKeyPem"

  field :replication_factor, 4,
    proto3_optional: true,
    type: :int32,
    json_name: "replicationFactor"

  field :replication_class, 5,
    proto3_optional: true,
    type: Astarte.RPC.Protocol.Housekeeping.ReplicationClass,
    json_name: "replicationClass",
    enum: true

  field :datacenter_replication_factors, 6,
    repeated: true,
    type: Astarte.RPC.Protocol.Housekeeping.UpdateRealm.DatacenterReplicationFactorsEntry,
    json_name: "datacenterReplicationFactors",
    map: true
end
