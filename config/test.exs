use Mix.Config

config :astarte_rpc, :amqp_connection, host: System.get_env("RABBITMQ_HOST") || "rabbitmq"

config :astarte_rpc, :amqp_queue, "test_queue"

config :os_mon,
  start_cpu_sup: false,
  start_disksup: false,
  start_memsup: false
