require 'flic/protocol'

require 'bindata'

module Flic
  module Protocol
    module Primitives
      # An abstract class for 1 byte enums
      class Enum < BinData::Primitive
        class Error < StandardError; end
        class InvalidOptionError < Error; end
        class InvalidOctetError < Error; end

        class << self
          # @return [Hash] a map of options to byte values
          def option_octet
            @option_octet ||= {}
          end

          # @return [Hash] a map of byte values to options
          def octet_option
            @octet_option ||= {}
          end

          # @return [Array] the valid options for this enum
          def options
            option_octet.keys
          end

          # @return [Array] the valid byte values for this enum
          def octets
            octet_option.keys
          end

          # @return [Integer] the byte value for the option with the largest byte value
          def max_octet
            octets.max
          end

          # @return [Integer] the next available byte value (starting at 0x00)
          def next_available_octet
            if max_octet
              1 + max_octet
            else
              0
            end
          end

          private

          # Associates an option with a byte value of the enum
          # @param option [Symbol]
          # @param octet [Integer] (defaults to the next available byte value)
          def option(option, octet = next_available_octet)
            option_octet[option] = octet
            octet_option[octet] = option
          end

          # Associates a byte value of an enum with an option
          def octet(octet, option)
            octet_option[octet] = option
            option_octet[option] = octet
          end
        end

        uint8le :octet

        def get
          if octet_option.has_key?(octet)
            octet_option[octet]
          else
            raise InvalidOctetError, "No such octet `#{octet.inspect}` for enum #{inspect}"
          end
        end

        def set(option)
          if option_octet.has_key?(option)
            self.octet = self.class.option_octet[option]
          else
            raise InvalidOptionError, "No such option `#{option.inspect}` for enum #{inspect}"
          end
        end

        private

        def octet_option
          self.class.octet_option
        end

        def option_octet
          self.class.option_octet
        end
      end
    end
  end
end