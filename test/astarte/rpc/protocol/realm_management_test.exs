defmodule Astarte.RPC.Protocol.RealmManagementTest do
  use ExUnit.Case

  @test_interface_json """
  {
    "interface_name": com.test.Interface,
    "version_major": 1,
    "version_minor": 0,
    "type": "properties",
    "ownership": "thing",
    "mappings": [
      {
        "path": "/test",
        "type": "string"
      }
    ]
  }
  """

  test "RealmManagement Protobuf round trip" do
    install_interface_call = Astarte.RPC.Protocol.RealmManagement.InstallInterface.new(realm_name: "test_realm", interface_json: @test_interface_json)
    version = 1
    rpc = Astarte.RPC.Protocol.RealmManagement.Call.new(call: {:install_interface, install_interface_call},
                                                        version: version)
    encoded = Astarte.RPC.Protocol.RealmManagement.Call.encode(rpc)
    decoded = Astarte.RPC.Protocol.RealmManagement.Call.decode(encoded)
    %Astarte.RPC.Protocol.RealmManagement.Call{call: {:install_interface, matched_call},
                                               version: matched_version} = decoded
    assert(matched_call == install_interface_call)
    assert(matched_version == version)
  end
end
