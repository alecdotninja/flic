require 'flic/protocol/primitives'

module Flic
  module Protocol
    module Primitives
      # Time in seconds after the Flic button may disconnect after the latest press or release. The button will reconnect automatically when it is later pressed again and deliver its enqueued events. Valid values are 0 - 511.
      class DisconnectTime < BinData::Primitive
        uint16le :time, initial_value: 512

        def get
          if time == 512
            nil
          else
            time
          end
        end

        def set(value)
          if value == 512
            raise RangeError, '512 is a special value that cannot be used for disconnect_time'
          elsif value
            self.time = value
          else
            self.time = 512
          end
        end
      end
    end
  end
end