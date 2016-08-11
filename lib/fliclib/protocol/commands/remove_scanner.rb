require 'fliclib/protocol/commands'
require 'fliclib/protocol/commands/command'

module Fliclib
  module Protocol
    module Commands
      class RemoveScanner < Command
        endian :little

        uint32 :scan_id
      end
    end
  end
end
