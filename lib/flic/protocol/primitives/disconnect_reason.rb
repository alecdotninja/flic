require 'flic/protocol/primitives'
require 'flic/protocol/primitives/enum'

module Flic
  module Protocol
    module Primitives
      class DisconnectReason < Enum
        option :unspecified                       # Unknown reason
        option :connection_establishment_failed   # The bluetooth controller established a connection, but the Flic button didn't answer in time.
        option :timed_out                         # The connection to the Flic button was lost due to either being out of range or some radio communication problems.
        option :bonding_keys_mismatch             # The server and the Flic button for some reason don't agree on the previously established bonding keys.
      end
    end
  end
end