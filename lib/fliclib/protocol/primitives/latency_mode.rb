require 'fliclib/protocol/primitives'
require 'fliclib/protocol/primitives/enum'

module Fliclib
  module Protocol
    module Primitives
      class LatencyMode < Enum
        option :normal    # Up to 100 ms latency.
        option :low       # Up to 17.5 ms latency.
        option :high      # Up to 275 ms latency.
      end
    end
  end
end