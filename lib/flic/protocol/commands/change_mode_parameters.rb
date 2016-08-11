require 'flic/protocol/commands'
require 'flic/protocol/commands/command'
require 'flic/protocol/primitives/latency_mode'

module Flic
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
