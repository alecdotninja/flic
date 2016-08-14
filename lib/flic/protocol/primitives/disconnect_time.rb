require 'flic/protocol/primitives'

module Flic
  module Primitives
    class DisconnectTime < BinData::Primitive
      endian :little

      uint16 :time, initial_value: 512

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
          self.time = nil
        end
      end
    end
  end
end