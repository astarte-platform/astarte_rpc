defmodule Astarte.RPC.Protocol.HousekeepingTest do
  use ExUnit.Case

  test "Housekeeping Protobuf round trip" do
    create_realm_call = Astarte.RPC.Protocol.Housekeeping.CreateRealm.new(realm: "testRealm")
    version = 42
    rpc = Astarte.RPC.Protocol.Housekeeping.Call.new(call: {:create_realm, create_realm_call},
                                                     version: version)
    encoded = Astarte.RPC.Protocol.Housekeeping.Call.encode(rpc)
    decoded = Astarte.RPC.Protocol.Housekeeping.Call.decode(encoded)
    %Astarte.RPC.Protocol.Housekeeping.Call{call: {:create_realm, matched_call},
                                            version: matched_version} = decoded
    assert(matched_call == create_realm_call)
    assert(matched_version == version)
  end
end
