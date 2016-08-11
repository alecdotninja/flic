require 'fliclib/protocol'

require 'bindata'

module Fliclib
  module Protocol
    class PacketHeader < BinData::Record
      endian :little
      uint16 :byte_length
    end
  end
end
