require 'fliclib/protocol/commands'
require 'fliclib/protocol/commands/command'

module Fliclib
  module Protocol
    module Commands
      class RemoveConnectionChannel < Command
        endian :little

        uint32 :connection_id
      end
    end
  end
end
