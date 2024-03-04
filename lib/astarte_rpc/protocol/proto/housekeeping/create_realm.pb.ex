defmodule Astarte.RPC.Protocol.Housekeeping.CreateRealm.DatacenterReplicationFactorsEntry do
  @moduledoc false

  use Protobuf, map: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :key, 1, type: :string
  field :value, 2, type: :int32
end

defmodule Astarte.RPC.Protocol.Housekeeping.CreateRealm do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :realm, 1, proto3_optional: true, type: :string
  field :async_operation, 2, type: :bool, json_name: "asyncOperation"
  field :jwt_public_key_pem, 3, proto3_optional: true, type: :string, json_name: "jwtPublicKeyPem"
  field :replication_factor, 4, type: :int32, json_name: "replicationFactor"

  field :replication_class, 5,
    type: Astarte.RPC.Protocol.Housekeeping.ReplicationClass,
    json_name: "replicationClass",
    enum: true

  field :datacenter_replication_factors, 6,
    repeated: true,
    type: Astarte.RPC.Protocol.Housekeeping.CreateRealm.DatacenterReplicationFactorsEntry,
    json_name: "datacenterReplicationFactors",
    map: true

  field :device_registration_limit, 7,
    proto3_optional: true,
    type: :int64,
    json_name: "deviceRegistrationLimit"

  field :datastream_maximum_storage_retention, 8,
    type: :int64,
    json_name: "datastreamMaximumStorageRetention"
end
