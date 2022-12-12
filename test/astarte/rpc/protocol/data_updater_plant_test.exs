#
# This file is part of Astarte.
#
# Copyright 2022 SECO Mind Srl
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

defmodule Astarte.RPC.Protocol.DataUpdaterPlantTest do
  use ExUnit.Case

  describe "payload serialized with ExProtobuf" do
    test "still works for DeleteVolatileTrigger" do
      alias Astarte.RPC.Protocol.DataUpdaterPlant.DeleteVolatileTrigger

      serialized_payload =
        <<10, 4, 116, 101, 115, 116, 18, 22, 73, 68, 66, 54, 50, 68, 100, 89, 83, 121, 71, 105,
          100, 50, 97, 81, 114, 100, 71, 97, 82, 81, 26, 36, 57, 48, 49, 55, 101, 100, 55, 56, 45,
          51, 99, 54, 53, 45, 52, 51, 55, 101, 45, 57, 56, 54, 98, 45, 56, 52, 55, 99, 100, 57,
          56, 53, 51, 100, 50, 98>>

      delete_trigger_call = %DeleteVolatileTrigger{
        realm_name: "test",
        device_id: "IDB62DdYSyGid2aQrdGaRQ",
        trigger_id: "9017ed78-3c65-437e-986b-847cd9853d2b"
      }

      assert DeleteVolatileTrigger.encode(delete_trigger_call) == serialized_payload
      assert DeleteVolatileTrigger.decode(serialized_payload) == delete_trigger_call
    end
  end
end
