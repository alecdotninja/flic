require 'fliclib/protocol/commands'
require 'fliclib/protocol/commands/command'
require 'fliclib/protocol/primitives/bluetooth_address'

module Fliclib
  module Protocol
    module Commands
      class ForceDisconnect < Command
        endian :little

        uint32 :connection_id
        bluetooth_address :bluetooth_address
      end
    end
  end
end
