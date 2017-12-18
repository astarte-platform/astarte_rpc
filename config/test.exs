use Mix.Config

config :astarte_rpc, :amqp_connection,
  host: "rabbitmq"

config :astarte_rpc, :amqp_queue,
  "test_queue"
