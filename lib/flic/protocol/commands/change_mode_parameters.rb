require 'flic/protocol/commands'
require 'flic/protocol/commands/command'
require 'flic/protocol/primitives/latency_mode'
require 'flic/protocol/primitives/disconnect_time'

module Flic
  module Protocol
    module Commands
      class ChangeModeParameters < Command
        endian :little

        uint32 :connection_channel_id
        latency_mode :latency_mode
        disconnect_time :auto_disconnect_time
      end
    end
  end
end
