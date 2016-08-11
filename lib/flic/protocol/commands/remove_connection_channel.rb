require 'flic/protocol/commands'
require 'flic/protocol/commands/command'

module Flic
  module Protocol
    module Commands
      class RemoveConnectionChannel < Command
        endian :little

        uint32 :connection_id
      end
    end
  end
end
