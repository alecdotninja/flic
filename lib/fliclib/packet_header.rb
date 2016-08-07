require 'fliclib'

require 'bindata'

module Fliclib
  class PacketHeader < BinData::Record
    endian :little
    uint16 :byte_length
  end
end
