require 'fliclib/protocol'

require 'bindata'

module Fliclib
  module Protocol
    module Primitives
      class Enum < BinData::Primitive
        class Error < StandardError; end
        class InvalidOptionError < Error; end
        class InvalidOctetError < Error; end

        class << self
          def option_octet
            @option_octet ||= {}
          end

          def octet_option
            @octet_option ||= {}
          end

          def options
            option_octet.keys
          end

          def octets
            octet_option.keys
          end

          def max_octet
            octets.max
          end

          def next_available_octet
            if max_octet
              1 + max_octet
            else
              0
            end
          end

          private

          def option(option, octet = next_available_octet)
            option_octet[option] = octet
            octet_option[octet] = option
          end

          def octet(octet, option)
            octet_option[octet] = option
            option_octet[option] = octet
          end
        end

        uint8 :octet

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