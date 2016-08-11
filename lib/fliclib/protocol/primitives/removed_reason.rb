require 'fliclib/protocol/primitives'
require 'fliclib/protocol/primitives/enum'

module Fliclib
  module Protocol
    module Primitives
      class RemovedReason < Enum
        option :removed_by_this_client                # The connection channel was removed by this client.
        option :force_disconnected_by_this_client     # The connection channel was removed due to a force disconnect by this client.
        option :force_disconnected_by_other_client    # Another client force disconnected the button used in this connection channel.
        option :button_is_private                     # The button is not in public mode. Hold it down for 7 seconds while not trying to establish a connection, then try to reconnect by creating a new connection channel.
        option :verify_timeout                        # After the connection was established, the bonding procedure didn't complete in time.
        option :internet_backend_error                # The internet request to the Flic backend failed.
        option :invalid_data                          # According to the Flic backend, this Flic button supplied invalid identity data.
      end
    end
  end
end