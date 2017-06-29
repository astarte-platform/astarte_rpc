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
    install_interface_call = Astarte.RPC.Protocol.RealmManagement.InstallInterface.new(interface_json: @test_interface_json)
    reply_header = Astarte.RPC.Protocol.RealmManagement.ReplyHeader.new(call_id: 42, reply_exchange: "myTestExchange")
    version = 1
    rpc = Astarte.RPC.Protocol.RealmManagement.Call.new(call: {:install_interface, install_interface_call},
                                                        reply_header: reply_header,
                                                        version: version)
    encoded = Astarte.RPC.Protocol.RealmManagement.Call.encode(rpc)
    decoded = Astarte.RPC.Protocol.RealmManagement.Call.decode(encoded)
    %Astarte.RPC.Protocol.RealmManagement.Call{call: {:install_interface, matched_call},
                           reply_header: matched_reply_header,
                           version: matched_version} = decoded
    assert(matched_call == install_interface_call)
    assert(matched_reply_header == reply_header)
    assert(matched_version == version)
  end

  test "that we know when to reply from RealmManagement" do
    install_interface_call = Astarte.RPC.Protocol.RealmManagement.InstallInterface.new(interface_json: @test_interface_json)
    version = 42
    rpc = Astarte.RPC.Protocol.RealmManagement.Call.new(call: {:install_interface_call, install_interface_call},
                                                        version: version)

    willReply = case rpc do
      %Astarte.RPC.Protocol.RealmManagement.Call{reply_header: nil} -> false
      _ -> true
    end
    assert(willReply == false)
  end
end
