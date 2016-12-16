require 'flic/protocol/primitives'

module Flic
  module Protocol
    module Primitives
      # Time in seconds after the Flic button may disconnect after the latest press or release. The button will reconnect automatically when it is later pressed again and deliver its enqueued events. Valid values are 0 - 511.
      class DisconnectTime < BinData::Primitive
        uint16le :time, initial_value: 511

        def get
          if time == 511
            nil
          else
            time
          end
        end

        def set(value)
          if value == nil
            self.time = 511
          elsif value >= 511
            raise RangeError, 'disconnect_time must be less than 511 seconds (or nil for never)'
          else
            self.time = value
          end
        end
      end
    end
  end
end