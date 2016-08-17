require 'flic/protocol'

require 'bindata'

module Flic
  module Protocol
    # Every packet starts with a packet header that includes the length of the remaining packet
    class PacketHeader < BinData::Record
      uint16le :byte_length
    end
  end
end
