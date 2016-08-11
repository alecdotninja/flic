require 'flic/protocol'

require 'bindata'

module Flic
  module Protocol
    class PacketHeader < BinData::Record
      endian :little
      uint16 :byte_length
    end
  end
end
