defmodule Astarte.RPC.Protocol.RealmManagement.GetDeviceRegistrationLimitReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GetDeviceRegistrationLimitReply"

  field :device_registration_limit, 1,
    proto3_optional: true,
    type: :int64,
    json_name: "deviceRegistrationLimit"
end
