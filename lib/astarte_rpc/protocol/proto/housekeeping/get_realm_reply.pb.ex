defmodule Astarte.RPC.Protocol.Housekeeping.GetRealmReply.DatacenterReplicationFactorsEntry do
  @moduledoc false

  use Protobuf, map: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :key, 1, type: :string
  field :value, 2, type: :int32
end

defmodule Astarte.RPC.Protocol.Housekeeping.GetRealmReply do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :realm_name, 1, proto3_optional: true, type: :string, json_name: "realmName"
  field :jwt_public_key_pem, 2, proto3_optional: true, type: :string, json_name: "jwtPublicKeyPem"
  field :replication_factor, 3, type: :int32, json_name: "replicationFactor"

  field :replication_class, 4,
    type: Astarte.RPC.Protocol.Housekeeping.ReplicationClass,
    json_name: "replicationClass",
    enum: true

  field :datacenter_replication_factors, 5,
    repeated: true,
    type: Astarte.RPC.Protocol.Housekeeping.GetRealmReply.DatacenterReplicationFactorsEntry,
    json_name: "datacenterReplicationFactors",
    map: true

  field :device_registration_limit, 6,
    proto3_optional: true,
    type: :int64,
    json_name: "deviceRegistrationLimit"

  field :datastream_maximum_storage_retention, 7,
    type: :int64,
    json_name: "datastreamMaximumStorageRetention"
end
