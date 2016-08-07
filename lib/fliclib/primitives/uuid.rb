require 'fliclib/primitives'

require 'bindata'
require 'scanf'

module Fliclib
  module Primitives
    class Uuid < BinData::Primitive
      PRINTF_FORMAT_STRING = '%.2X%.2X%.2X%.2X-%.2X%.2X-%.2X%.2X-%.2X%.2X-%.2X%.2X%.2X%.2X%.2X%.2X'.freeze
      SCANF_FORMAT_STRING = '%X%X%X%X-%X%X-%X%X-%X%X-%X%X%X%X%X%X'.freeze

      array :octets, type: :uint8, initial_length: 16

      def get
        sprintf(PRINTF_FORMAT_STRING, *octets)
      end

      def set(value)
        self.octets = value.scanf(SCANF_FORMAT_STRING)
      end
    end
  end
end