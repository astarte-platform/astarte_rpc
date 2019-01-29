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
    create_realm_call = Astarte.RPC.Protocol.Housekeeping.CreateRealm.new(realm: "testRealm")
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
end
