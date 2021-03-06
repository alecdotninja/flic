require 'flic/protocol/primitives'

require 'bindata'

module Flic
  module Protocol
    module Primitives
      # The name of a device (up to 16 character string)
      class DeviceName < BinData::Primitive
        BYTE_LENGTH = 16

        uint8 :byte_length
        array :bytes, type: :int8le, initial_length: BYTE_LENGTH

        def get
          ''.tap do |string|
            byte_length.times do |index|
              break unless index < BYTE_LENGTH
              string << bytes[index].to_i
            end
          end
        end

        def set(value)
          byte_length = 0
          bytes = []

          BYTE_LENGTH.times do |index|
            char = value[index].to_s

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
end