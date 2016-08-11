require 'fliclib/protocol/primitives'

module Fliclib
  module Protocol
    module Primitives
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