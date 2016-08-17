require 'flic/protocol/primitives'

require 'bindata'
require 'scanf'

module Flic
  module Protocol
    module Primitives
      # A bluetooth address (bdaddr_t) is encoded in little endan, 6 bytes in total. When such an address is written as a string, it is normally written in big endian, where each byte is encoded in hex and colon as separator for each byte. For example, the address 08:09:0a:0b:0c:0d is encoded as the bytes 0x0d, 0x0c, 0x0b, 0x0a, 0x09, 0x08.
      class BluetoothAddress < BinData::Primitive
        PRINTF_FORMAT_STRING = '%.2X:%.2X:%.2X:%.2X:%.2X:%.2X'.freeze
        SCANF_FORMAT_STRING = '%X:%X:%X:%X:%X:%X'.freeze

        array :little_endian_octets, type: :uint8le, initial_length: 6

        def get
          sprintf(PRINTF_FORMAT_STRING, *big_endian_octets)
        end

        def set(value)
          self.big_endian_octets = value.scanf(SCANF_FORMAT_STRING)
        end

        private

        def big_endian_octets
          little_endian_octets.to_a.reverse
        end

        def big_endian_octets=(big_endian_octets)
          self.little_endian_octets = big_endian_octets.to_a.reverse
        end
      end
    end
  end
end