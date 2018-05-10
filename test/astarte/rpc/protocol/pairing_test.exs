defmodule Astarte.RPC.Protocol.PairingTest do
  use ExUnit.Case

  alias Astarte.RPC.Protocol.Pairing.Reply
  alias Astarte.RPC.Protocol.Pairing.VerifyCertificateReply

  test "RealmManagement Protobuf round trip" do
    verify_cert_reply =
      %VerifyCertificateReply{
        valid: false,
        timestamp: 123456123456,
        until: 654321654321,
        cause: :INVALID_SIGNATURE,
        details: "Not trusted"
      }
    version = 1

    rpc_reply =
      %Reply{
        reply: {:verify_certificate_reply, verify_cert_reply},
        version: version
      }

    encoded = Reply.encode(rpc_reply)
    decoded = Reply.decode(encoded)

    %Reply{reply: {:verify_certificate_reply, matched_reply}, version: matched_version} = decoded

    assert(matched_reply == verify_cert_reply)
    assert(matched_version == version)
  end
end
