require 'flic/protocol/commands'
require 'flic/protocol/commands/command'
require 'flic/protocol/primitives/bluetooth_address'
require 'flic/protocol/primitives/latency_mode'

module Flic
  module Protocol
    module Commands
      class CreateConnectionChannel < Command
        endian :little

        uint32 :connection_id
        bluetooth_address :bluetooth_address

        latency_mode :latency_mode
        uint16 :auto_disconnect_time, initial_value: 512 # 512 means disabled
      end
    end
  end
end
