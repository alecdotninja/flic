require 'fliclib/commands'
require 'fliclib/commands/command'
require 'fliclib/primitives/bluetooth_address'

module Fliclib
  module Commands
    class ForceDisconnect < Command
      endian :little

      uint32 :connection_id
      bluetooth_address :bluetooth_address
    end
  end
end
