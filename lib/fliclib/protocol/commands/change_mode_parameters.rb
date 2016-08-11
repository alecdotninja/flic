require 'fliclib/protocol/commands'
require 'fliclib/protocol/commands/command'
require 'fliclib/protocol/primitives/latency_mode'

module Fliclib
  module Protocol
    module Commands
      class ChangeModeParameters < Command
        endian :little

        uint32 :connection_id
        latency_mode :latency_mode
        uint16 :auto_disconnect_time
      end
    end
  end
end
