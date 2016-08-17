require 'flic/protocol'

require 'bindata'

module Flic
  module Protocol
    class PacketHeader < BinData::Record
      uint16le :byte_length
    end
  end
end
