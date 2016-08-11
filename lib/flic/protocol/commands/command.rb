require 'flic/protocol/commands'

require 'bindata'

module Flic
  module Protocol
    module Commands
      class Command < BinData::Record
        endian :little

        uint8 :opcode, initial_value: -> { init_opcode }

        private

        def init_opcode
          Commands.opcode_for_command_class(self.class)
        end
      end
    end
  end
end
