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
end
