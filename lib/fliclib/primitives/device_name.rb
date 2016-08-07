require 'fliclib/primitives'

require 'bindata'

module Fliclib
  module Primitives
    class DeviceName < BinData::Primitive
      BYTE_LENGTH = 16

      uint8 :byte_length
      array :bytes, type: :int8, initial_length: BYTE_LENGTH

      def get
        ''.tap do |string|
          byte_length.times do |index|
            break unless index < BYTE_LENGTH
            string << bytes[index]
          end
        end
      end

      def set(value)
        byte_length = 0
        bytes = []

        BYTE_LENGTH.times do |index|
          char = value[index]

          if char
            bytes << char.ord
            byte_length += 1
          else
            bytes << 0
          end
        end

        self.byte_length = byte_length
        self.bytes = bytes
      end
    end
  end
end