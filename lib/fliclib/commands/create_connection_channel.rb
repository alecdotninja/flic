require 'fliclib/commands'
require 'fliclib/commands/command'
require 'fliclib/primitives/bluetooth_address'
require 'fliclib/primitives/latency_mode'

module Fliclib
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
