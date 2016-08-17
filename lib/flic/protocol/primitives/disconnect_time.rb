require 'flic/protocol/primitives'

module Flic
  module Protocol
    module Primitives
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