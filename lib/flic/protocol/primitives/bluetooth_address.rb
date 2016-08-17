require 'flic/protocol/primitives'

require 'bindata'
require 'scanf'

module Flic
  module Protocol
    module Primitives
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