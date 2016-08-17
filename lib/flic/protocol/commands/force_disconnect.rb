require 'flic/protocol/commands'
require 'flic/protocol/commands/command'
require 'flic/protocol/primitives/bluetooth_address'

module Flic
  module Protocol
    module Commands
      class ForceDisconnect < Command
        bluetooth_address :bluetooth_address
      end
    end
  end
end
