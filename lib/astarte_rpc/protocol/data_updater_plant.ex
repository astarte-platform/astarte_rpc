#
# Copyright (C) 2018 Ispirata Srl
#
# This file is part of Astarte.
# Astarte is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Astarte is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with Astarte.  If not, see <http://www.gnu.org/licenses/>.
#

defmodule Astarte.RPC.Protocol.DataUpdaterPlant do
  @external_resource Path.expand("proto/data_updater_plant", __DIR__)

  use Protobuf, from: Path.wildcard(Path.expand("proto/data_updater_plant/*.proto", __DIR__))
  use Astarte.RPC.Protocol, amqp_queue: "data_updater_plant_rpc"
end
