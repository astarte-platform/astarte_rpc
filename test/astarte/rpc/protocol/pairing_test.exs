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

defmodule Astarte.RPC.Protocol.PairingTest do
  use ExUnit.Case

  alias Astarte.RPC.Protocol.Pairing.AstarteMQTTV1CredentialsStatus
  alias Astarte.RPC.Protocol.Pairing.Reply
  alias Astarte.RPC.Protocol.Pairing.VerifyCredentialsReply

  test "Pairing Protobuf round trip" do
    astarte_credentials_status = %AstarteMQTTV1CredentialsStatus{
      valid: false,
      timestamp: 123_456_123_456,
      until: 654_321_654_321,
      cause: :INVALID_SIGNATURE,
      details: "Not trusted"
    }

    verify_credentials_reply = %VerifyCredentialsReply{
      credentials_status: {:astarte_mqtt_v1, astarte_credentials_status}
    }

    version = 1

    rpc_reply = %Reply{
      reply: {:verify_credentials_reply, verify_credentials_reply},
      version: version
    }

    encoded = Reply.encode(rpc_reply)
    decoded = Reply.decode(encoded)

    %Reply{reply: {:verify_credentials_reply, matched_reply}, version: matched_version} = decoded

    assert(matched_reply == verify_credentials_reply)
    assert(matched_version == version)
  end
end
