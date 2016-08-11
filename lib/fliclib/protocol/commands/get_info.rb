require 'fliclib/protocol/commands'
require 'fliclib/protocol/commands/command'

module Fliclib
  module Protocol
    module Commands
      class GetInfo < Command
        endian :little
      end
    end
  end
end
