require 'fliclib/enum'

require 'bindata'

module Fliclib
  module Primitives
    class LatencyMode < BinData::Primitive
      include Enum

      option :normal    # Up to 100 ms latency.
      option :low       # Up to 17.5 ms latency.
      option :high      # Up to 275 ms latency.
    end
  end
end