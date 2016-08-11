require 'flic/protocol/commands'
require 'flic/protocol/commands/command'

module Flic
  module Protocol
    module Commands
      class GetInfo < Command
        endian :little
      end
    end
  end
end
