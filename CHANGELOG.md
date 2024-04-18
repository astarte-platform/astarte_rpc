# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.0.6] - 2024-04-18

## [1.0.5] - 2023-09-25

## [1.0.4] - 2022-09-26

## [1.0.3] - 2022-07-04

## [1.0.2] - 2022-03-29

## [1.0.1] - 2021-12-16

## [1.0.0] - 2021-06-28

## [1.0.0-rc.0] - 2021-05-05
### Changed
- Test against RabbitMQ 3.8.16

## [1.0.0-beta.2] - 2021-03-23
### Changed
- Update dependencies and Elixir version to 1.11
- Test against RabbitMQ 3.8.14

## [1.0.0-beta.1] - 2021-02-11

## [1.0.0-alpha.1] - 2020-06-18
### Added
- Add `PublishReply` to allow VerneMQ returning the number of matched clients after a publish.

### Changed
- Handle env variables with Skogsra
- Change env variable ASTARTE_RPC_AMQP_CONNECTION_USERNAME into RPC_AMQP_CONNECTION_USERNAME
- Change env variable ASTARTE_RPC_AMQP_CONNECTION_PASSWORD into RPC_AMQP_CONNECTION_PASSWORD
- Change env variable ASTARTE_RPC_AMQP_CONNECTION_HOST into RPC_AMQP_CONNECTION_HOST
- Change env variable ASTARTE_RPC_AMQP_CONNECTION_VIRTUAL_HOST into RPC_AMQP_CONNECTION_VIRTUAL_HOST
- Change env variable ASTARTE_RPC_AMQP_CONNECTION_PORT into RPC_AMQP_CONNECTION_PORT
- Change env variable ASTARTE_RPC_AMQP_PREFETCH_COUNT into RPC_AMQP_PREFETCH_COUNT
- Change env variable ASTARTE_RPC_AMQP_QUEUE_MAX_LENGTH into RPC_AMQP_QUEUE_MAX_LENGTH

### Added
- Support SSL connections to RabbitMQ.
- Default max certificate chain length to 10.

## [0.11.4] - 2021-01-25

## [0.11.3] - 2020-09-24

## [0.11.2] - 2020-08-14
### Changed
- Test against Elixir 1.8.2.

## [0.11.1] - 2020-05-18

## [0.11.0] - 2020-04-06

## [0.11.0-rc.1] - 2020-03-25

## [0.11.0-rc.0] - 2020-02-26
### Fixed
- Make .proto files fully compliant with Protocol Buffers Version 3.

## [0.11.0-beta.2] - 2020-01-24

## [0.11.0-beta.1] - 2019-12-24
### Added
- Add `initial_introspection` to RegisterDevice.

## [0.10.2] - 2019-12-09
### Added
- Add `UnregisterDevice` call to Pairing protocol.

## [0.10.1] - 2019-10-02
### Added
- Add replication_class and datacenter_replication_factors fields to {Create,Get}Realm requests.

## [0.10.0] - 2019-04-16

## [0.10.0-rc.0] - 2019-04-03

## [0.10.0-beta.3] - 2018-12-19

## [0.10.0-beta.2] - 2018-10-19

## [0.10.0-beta.1] - 2018-08-10
### Added
- First Astarte release.
