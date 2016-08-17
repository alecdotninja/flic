require 'flic/protocol/commands'

require 'bindata'

module Flic
  module Protocol
    module Commands
      class Command < BinData::Record
        uint8le :opcode, initial_value: :class_opcode, assert: :opcode_matcher

        private

        def class_opcode
          @@class_opcode ||= Commands.opcode_for_command_class(self.class)
        end

        def opcode_matcher
          if class_opcode
            class_opcode
          else
            true
          end
        end
      end
    end
  end
end
