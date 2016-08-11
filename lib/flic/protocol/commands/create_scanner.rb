require 'flic/protocol/commands'
require 'flic/protocol/commands/command'

module Flic
  module Protocol
    module Commands
      class CreateScanner < Command
        endian :little

        uint32 :scan_id
      end
    end
  end
end
