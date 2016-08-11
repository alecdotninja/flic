require 'flic/protocol/events'

require 'bindata'

module Flic
  module Protocol
    module Events
      class Event < BinData::Record
        endian :little

        uint8 :opcode, initial_value: -> { init_opcode }

        private

        def init_opcode
          Event.opcode_for_event_class(self.class)
        end
      end
    end
  end
end
