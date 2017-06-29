defmodule Astarte.RPC.Protocol.HousekeepingTest do
  use ExUnit.Case

  test "Housekeeping Protobuf round trip" do
    create_realm_call = Astarte.RPC.Protocol.Housekeeping.CreateRealm.new(realm: "testRealm")
    reply_header = Astarte.RPC.Protocol.Housekeeping.ReplyHeader.new(call_id: 42, reply_exchange: "testExchange")
    version = 42
    rpc = Astarte.RPC.Protocol.Housekeeping.Call.new(call: {:create_realm, create_realm_call},
                                    reply_header: reply_header,
                                    version: version)
    encoded = Astarte.RPC.Protocol.Housekeeping.Call.encode(rpc)
    decoded = Astarte.RPC.Protocol.Housekeeping.Call.decode(encoded)
    %Astarte.RPC.Protocol.Housekeeping.Call{call: {:create_realm, matched_call},
                           reply_header: matched_reply_header,
                           version: matched_version} = decoded
    assert(matched_call == create_realm_call)
    assert(matched_reply_header == reply_header)
    assert(matched_version == version)
  end

  test "that we know when to reply from Housekeeping" do
    create_realm_call = Astarte.RPC.Protocol.Housekeeping.CreateRealm.new(realm: "testRealm")
    version = 42
    rpc = Astarte.RPC.Protocol.Housekeeping.Call.new(call: {:create_realm, create_realm_call},
                                    version: version)

    willReply = case rpc do
      %Astarte.RPC.Protocol.Housekeeping.Call{reply_header: nil} -> false
      _ -> true
    end
    assert(willReply == false)
  end
end
