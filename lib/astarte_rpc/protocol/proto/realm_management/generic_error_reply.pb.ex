defmodule Astarte.RPC.Protocol.RealmManagement.GenericErrorReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  def fully_qualified_name, do: "GenericErrorReply"

  field :error_name, 1, proto3_optional: true, type: :string, json_name: "errorName"

  field :user_readable_error_name, 2,
    proto3_optional: true,
    type: :string,
    json_name: "userReadableErrorName"

  field :user_readable_message, 3,
    proto3_optional: true,
    type: :string,
    json_name: "userReadableMessage"

  field :error_data, 4, proto3_optional: true, type: :string, json_name: "errorData"
end
