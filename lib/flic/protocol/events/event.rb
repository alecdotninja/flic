require 'flic/protocol/events'

require 'bindata'

module Flic
  module Protocol
    module Events
      class Event < BinData::Record
        uint8le :opcode, initial_value: :class_opcode, assert: :opcode_matcher

        private

        def class_opcode
          @@class_opcode ||= Events.opcode_for_event_class(self.class)
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
