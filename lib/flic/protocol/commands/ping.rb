require 'flic/protocol/commands'
require 'flic/protocol/commands/command'

module Flic
  module Protocol
    module Commands
      class Ping < Command
        endian :little

        uint32 :ping_id
      end
    end
  end
end
