require 'flic/protocol/primitives'

module Flic
  module Protocol
    module Primitives
      # True or false encoded as a byte where 0x00 is false and all other values are true (however, 0x01 is preferred)
      class Boolean < BinData::Primitive
        uint8 :byte

        def get
          byte != 0x00
        end

        def set(value)
          self.byte = value ? 0x01 : 0x00
        end
      end
    end
  end
end