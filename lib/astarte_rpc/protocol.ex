defmodule Astarte.RPC.Protocol do
  @moduledoc """
  This is a utility module to inject a `__using__` macro to the
  Astarte.RPC.Protocol modules (e.g. Housekeeping, RealmManagement...).

  To do this just `use Astarte.RPC.Protocol`.

  The generated `__using__` macro makes it possible to do something like
  `use Astarte.RPC.Protocol.Housekeeping` and alias all the messages defined
  under the `Astarte.RPC.Protocol.Housekeeping`.
  """
  defmacro __using__(_opts) do
    inject_autoaliases_macro()
  end

  defp inject_autoaliases_macro() do
    quote unquote: false do
      defmacro __using__(_opts) do
        proto_msgs = __MODULE__.defs()
                     |> Enum.filter(fn elem -> match?({{:msg, _}, _}, elem) end)
                     |> Enum.map(fn _elem = {{:msg, msg}, _} -> msg end)

        Enum.map(proto_msgs, fn msg ->
          quote do
            alias unquote(msg)
          end
        end)
      end
    end
  end
end
