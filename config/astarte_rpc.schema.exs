@moduledoc """
A schema is a keyword list which represents how to map, transform, and validate
configuration values parsed from the .conf file. The following is an explanation of
each key in the schema definition in order of appearance, and how to use them.

## Import

A list of application names (as atoms), which represent apps to load modules from
which you can then reference in your schema definition. This is how you import your
own custom Validator/Transform modules, or general utility modules for use in
validator/transform functions in the schema. For example, if you have an application
`:foo` which contains a custom Transform module, you would add it to your schema like so:

`[ import: [:foo], ..., transforms: ["myapp.some.setting": MyApp.SomeTransform]]`

## Extends

A list of application names (as atoms), which contain schemas that you want to extend
with this schema. By extending a schema, you effectively re-use definitions in the
extended schema. You may also override definitions from the extended schema by redefining them
in the extending schema. You use `:extends` like so:

`[ extends: [:foo], ... ]`

## Mappings

Mappings define how to interpret settings in the .conf when they are translated to
runtime configuration. They also define how the .conf will be generated, things like
documention, @see references, example values, etc.

See the moduledoc for `Conform.Schema.Mapping` for more details.

## Transforms

Transforms are custom functions which are executed to build the value which will be
stored at the path defined by the key. Transforms have access to the current config
state via the `Conform.Conf` module, and can use that to build complex configuration
from a combination of other config values.

See the moduledoc for `Conform.Schema.Transform` for more details and examples.

## Validators

Validators are simple functions which take two arguments, the value to be validated,
and arguments provided to the validator (used only by custom validators). A validator
checks the value, and returns `:ok` if it is valid, `{:warn, message}` if it is valid,
but should be brought to the users attention, or `{:error, message}` if it is invalid.

See the moduledoc for `Conform.Schema.Validator` for more details and examples.
"""
[extends: [],
 import: [],
 mappings: [
    "astarte_rpc.amqp_connection.username": [
      commented: true,
      datatype: :binary,
      env_var: "ASTARTE_RPC_AMQP_CONNECTION_USERNAME",
      doc: "Username for accessing the AMQP broker.",
      default: "guest",
      hidden: false,
      required: false,
      to: "astarte_rpc.amqp_connection.username"
    ],
    "astarte_rpc.amqp_connection.password": [
      commented: true,
      datatype: :binary,
      env_var: "ASTARTE_RPC_AMQP_CONNECTION_PASSWORD",
      doc: "Password for accessing the AMQP broker.",
      default: "guest",
      hidden: false,
      required: false,
      to: "astarte_rpc.amqp_connection.password"
    ],
    "astarte_rpc.amqp_connection.host": [
      commented: true,
      datatype: :binary,
      env_var: "ASTARTE_RPC_AMQP_CONNECTION_HOST",
      doc: "The hostname or IP of the AMQP broker.",
      default: "localhost",
      hidden: false,
      required: false,
      to: "astarte_rpc.amqp_connection.host"
    ],
    "astarte_rpc.amqp_connection.virtual_host": [
      commented: true,
      datatype: :binary,
      env_var: "ASTARTE_RPC_AMQP_CONNECTION_VIRTUAL_HOST",
      doc: "The Virtual Host to be used in the AMQP broker. Must be the same for all components.",
      default: "/",
      hidden: false,
      required: false,
      to: "astarte_rpc.amqp_connection.virtual_host"
    ],
    "astarte_rpc.amqp_connection.port": [
      commented: true,
      datatype: :integer,
      env_var: "ASTARTE_RPC_AMQP_CONNECTION_PORT",
      doc: "The port of the AMQP broker to connect to.",
      default: 5672,
      hidden: false,
      required: false,
      to: "astarte_rpc.amqp_connection.port"
    ],
    "astarte_rpc.amqp_prefetch_count": [
      commented: true,
      datatype: :integer,
      env_var: "ASTARTE_RPC_AMQP_PREFETCH_COUNT",
      doc: "The prefetch count of the AMQP connection. A prefetch count of 0 means unlimited (not recommended).",
      default: 300,
      hidden: false,
      required: true,
      to: "astarte_rpc.amqp_prefetch_count"
    ],
    "astarte_rpc.amqp_queue_max_length": [
      commented: true,
      datatype: :integer,
      env_var: "ASTARTE_RPC_AMQP_QUEUE_MAX_LENGTH",
      doc:
        "Max length of the server AMQP queue. If defined, the queue will be limited to that length and new publishes will be dropped while the queue is full. WARNING: changing this value requires manually deleting the queue",
      hidden: false,
      required: false,
      to: "astarte_rpc.amqp_queue_max_length"
    ]
 ],
 transforms: [],
 validators: []]
