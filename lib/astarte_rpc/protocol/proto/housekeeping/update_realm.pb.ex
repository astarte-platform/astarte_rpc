defmodule Astarte.RPC.Protocol.Housekeeping.RemoveLimit do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto3
end

defmodule Astarte.RPC.Protocol.Housekeeping.SetLimit do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto3

  field :value, 1, type: :int64
end

defmodule Astarte.RPC.Protocol.Housekeeping.UpdateRealm.DatacenterReplicationFactorsEntry do
  @moduledoc false

  use Protobuf, map: true, protoc_gen_elixir_version: "0.12.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :int32
end

defmodule Astarte.RPC.Protocol.Housekeeping.UpdateRealm do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto3

  oneof :device_registration_limit, 0

  field :realm, 1, proto3_optional: true, type: :string
  field :jwt_public_key_pem, 3, proto3_optional: true, type: :string, json_name: "jwtPublicKeyPem"

  field :replication_factor, 4,
    proto3_optional: true,
    type: :int32,
    json_name: "replicationFactor"

  field :replication_class, 5,
    proto3_optional: true,
    type: ReplicationClass,
    json_name: "replicationClass",
    enum: true

  field :datacenter_replication_factors, 6,
    repeated: true,
    type: Astarte.RPC.Protocol.Housekeeping.UpdateRealm.DatacenterReplicationFactorsEntry,
    json_name: "datacenterReplicationFactors",
    map: true

  field :set_limit, 7,
    type: Astarte.RPC.Protocol.Housekeeping.SetLimit,
    json_name: "setLimit",
    oneof: 0

  field :remove_limit, 8,
    type: Astarte.RPC.Protocol.Housekeeping.RemoveLimit,
    json_name: "removeLimit",
    oneof: 0
end
