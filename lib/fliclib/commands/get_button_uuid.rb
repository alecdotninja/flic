require 'fliclib/commands'
require 'fliclib/commands/command'
require 'fliclib/primitives/bluetooth_address'

module Fliclib
  module Commands
    class GetButtonUuid < Command
      endian :little

      bluetooth_address :bluetooth_address
    end
  end
end
