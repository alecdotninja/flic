require 'flic/protocol/primitives'

require 'bindata'
require 'scanf'

module Flic
  module Protocol
    module Primitives
      # The uuid of a button (nil is represented as all zeros)
      class Uuid < BinData::Primitive
        NULL_UUID_OCTETS = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].freeze
        PRINTF_FORMAT_STRING = '%.2X%.2X%.2X%.2X-%.2X%.2X-%.2X%.2X-%.2X%.2X-%.2X%.2X%.2X%.2X%.2X%.2X'.freeze
        SCANF_FORMAT_STRING = '%X%X%X%X-%X%X-%X%X-%X%X-%X%X%X%X%X%X'.freeze

        array :octets, type: :uint8le, initial_length: 16

        def get
          if NULL_UUID_OCTETS == octets
            nil
          else
            sprintf(PRINTF_FORMAT_STRING, *octets)
          end
        end

        def set(value)
          if value
            self.octets = value.scanf(SCANF_FORMAT_STRING)
          else
            self.octets = NULL_UUID_OCTETS
          end
        end
      end
    end
  end
end