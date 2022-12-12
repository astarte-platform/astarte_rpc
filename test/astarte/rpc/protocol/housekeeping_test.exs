#
# This file is part of Astarte.
#
# Copyright 2017 Ispirata Srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

defmodule Astarte.RPC.Protocol.HousekeepingTest do
  use ExUnit.Case

  test "Housekeeping Protobuf round trip" do
    create_realm_call =
      Astarte.RPC.Protocol.Housekeeping.CreateRealm.new(
        realm: "testRealm",
        async_operation: false,
        jwt_public_key_pem: "",
        replication_class: :SIMPLE_STRATEGY,
        replication_factor: 0
      )

    version = 42

    rpc =
      Astarte.RPC.Protocol.Housekeeping.Call.new(
        call: {:create_realm, create_realm_call},
        version: version
      )

    encoded = Astarte.RPC.Protocol.Housekeeping.Call.encode(rpc)
    decoded = Astarte.RPC.Protocol.Housekeeping.Call.decode(encoded)

    %Astarte.RPC.Protocol.Housekeeping.Call{
      call: {:create_realm, matched_call},
      version: matched_version
    } = decoded

    assert(matched_call == create_realm_call)
    assert(matched_version == version)
  end

  describe "payload serialized with ExProtobuf" do
    alias Astarte.RPC.Protocol.Housekeeping.CreateRealm

    test "still works for CreateRealm" do
      serialized_payload =
        <<10, 9, 116, 101, 115, 116, 82, 101, 97, 108, 109, 16, 1, 26, 16, 110, 111, 116, 97, 106,
          119, 116, 98, 117, 116, 119, 105, 108, 108, 100, 111, 32, 1, 40, 1>>

      create_realm_call =
        CreateRealm.new(
          realm: "testRealm",
          async_operation: true,
          jwt_public_key_pem: "notajwtbutwilldo",
          replication_class: :NETWORK_TOPOLOGY_STRATEGY,
          replication_factor: 1
        )

      assert CreateRealm.encode(create_realm_call) == serialized_payload
      assert CreateRealm.decode(serialized_payload) == create_realm_call
    end

    test "is correctly deserialized even if zero-values are set on the wire" do
      serialized_payload =
        <<10, 9, 116, 101, 115, 116, 82, 101, 97, 108, 109, 16, 0, 26, 0, 32, 0, 40, 0>>

      create_realm_call =
        CreateRealm.new(
          realm: "testRealm",
          async_operation: false,
          jwt_public_key_pem: "",
          replication_class: :SIMPLE_STRATEGY,
          replication_factor: 0
        )

      assert CreateRealm.decode(serialized_payload) == create_realm_call
    end
  end
end
