require 'fliclib/commands'
require 'fliclib/commands/command'
require 'fliclib/primitives/latency_mode'

module Fliclib
  module Commands
    class ChangeModeParameters < Command
      endian :little

      uint32 :connection_id
      latency_mode :latency_mode
      uint16 :auto_disconnect_time
    end
  end
end
