require 'fliclib/protocol/commands'
require 'fliclib/protocol/commands/command'

module Fliclib
  module Protocol
    module Commands
      class Ping < Command
        endian :little

        uint32 :ping_id
      end
    end
  end
end
