require 'flic/protocol/primitives'
require 'flic/protocol/primitives/enum'

module Flic
  module Protocol
    module Primitives
      # This specifies the accepted latency mode for the corresponding connection channel. The physical bluetooth connection will use the lowest mode set by any connection channel. The battery usage for the Flic button is normally about the same for all modes if the connection is stable. However lower modes will have higher battery usage if the connection is unstable. Lower modes also consumes more power for the client, which is normally not a problem since most computers run on wall power or have large batteries.
      # [:normal] Up to 100 ms latency.
      # [:low] Up to 17.5 ms latency.
      # [:high] Up to 275 ms latency.
      class LatencyMode < Enum
        option :normal
        option :low
        option :high
      end
    end
  end
end