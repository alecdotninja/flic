require 'fliclib/protocol/commands'
require 'fliclib/protocol/commands/command'
require 'fliclib/protocol/primitives/bluetooth_address'
require 'fliclib/protocol/primitives/latency_mode'

module Fliclib
  module Protocol
    module Commands
      class CreateConnectionChannel < Command
        endian :little

        uint32 :connection_id
        bluetooth_address :bluetooth_address

        latency_mode :latency_mode
        uint16 :auto_disconnect_time
      end
    end
  end
end
