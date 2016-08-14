require 'flic/protocol/commands'
require 'flic/protocol/commands/command'
require 'flic/protocol/primitives/bluetooth_address'
require 'flic/protocol/primitives/latency_mode'
require 'flic/protocol/primitives/disconnect_time'

module Flic
  module Protocol
    module Commands
      class CreateConnectionChannel < Command
        endian :little

        uint32 :connection_channel_id
        bluetooth_address :bluetooth_address

        latency_mode :latency_mode
        disconnect_time :auto_disconnect_time
      end
    end
  end
end
