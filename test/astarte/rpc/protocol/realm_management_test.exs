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

defmodule Astarte.RPC.Protocol.RealmManagementTest do
  use ExUnit.Case

  @test_interface_json """
  {
    "interface_name": com.test.Interface,
    "version_major": 1,
    "version_minor": 0,
    "type": "properties",
    "ownership": "device",
    "mappings": [
      {
        "path": "/test",
        "type": "string"
      }
    ]
  }
  """

  test "RealmManagement Protobuf round trip" do
    install_interface_call =
      Astarte.RPC.Protocol.RealmManagement.InstallInterface.new(
        realm_name: "test_realm",
        interface_json: @test_interface_json,
        async_operation: false
      )

    version = 1

    rpc =
      Astarte.RPC.Protocol.RealmManagement.Call.new(
        call: {:install_interface, install_interface_call},
        version: version
      )

    encoded = Astarte.RPC.Protocol.RealmManagement.Call.encode(rpc)
    decoded = Astarte.RPC.Protocol.RealmManagement.Call.decode(encoded)

    %Astarte.RPC.Protocol.RealmManagement.Call{
      call: {:install_interface, matched_call},
      version: matched_version
    } = decoded

    assert(matched_call == install_interface_call)
    assert(matched_version == version)
  end

  describe "payload serialized with ExProtobuf" do
    alias Astarte.RPC.Protocol.RealmManagement.InstallInterface

    test "still works for InstallInterface" do
      serialized_payload =
        <<10, 10, 116, 101, 115, 116, 95, 114, 101, 97, 108, 109, 18, 215, 1, 123, 10, 32, 32, 34,
          105, 110, 116, 101, 114, 102, 97, 99, 101, 95, 110, 97, 109, 101, 34, 58, 32, 99, 111,
          109, 46, 116, 101, 115, 116, 46, 73, 110, 116, 101, 114, 102, 97, 99, 101, 44, 10, 32,
          32, 34, 118, 101, 114, 115, 105, 111, 110, 95, 109, 97, 106, 111, 114, 34, 58, 32, 49,
          44, 10, 32, 32, 34, 118, 101, 114, 115, 105, 111, 110, 95, 109, 105, 110, 111, 114, 34,
          58, 32, 48, 44, 10, 32, 32, 34, 116, 121, 112, 101, 34, 58, 32, 34, 112, 114, 111, 112,
          101, 114, 116, 105, 101, 115, 34, 44, 10, 32, 32, 34, 111, 119, 110, 101, 114, 115, 104,
          105, 112, 34, 58, 32, 34, 100, 101, 118, 105, 99, 101, 34, 44, 10, 32, 32, 34, 109, 97,
          112, 112, 105, 110, 103, 115, 34, 58, 32, 91, 10, 32, 32, 32, 32, 123, 10, 32, 32, 32,
          32, 32, 32, 34, 112, 97, 116, 104, 34, 58, 32, 34, 47, 116, 101, 115, 116, 34, 44, 10,
          32, 32, 32, 32, 32, 32, 34, 116, 121, 112, 101, 34, 58, 32, 34, 115, 116, 114, 105, 110,
          103, 34, 10, 32, 32, 32, 32, 125, 10, 32, 32, 93, 10, 125, 10, 24, 1>>

      install_interface_call =
        InstallInterface.new(
          realm_name: "test_realm",
          interface_json: @test_interface_json,
          async_operation: true
        )

      assert InstallInterface.encode(install_interface_call) == serialized_payload
      assert InstallInterface.decode(serialized_payload) == install_interface_call
    end

    test "is correctly deserialized even if zero-values are set on the wire" do
      serialized_payload = <<10, 0, 18, 0, 24, 0>>

      install_interface_call =
        InstallInterface.new(
          realm_name: "",
          interface_json: "",
          async_operation: false
        )

      assert InstallInterface.decode(serialized_payload) == install_interface_call
    end
  end
end
