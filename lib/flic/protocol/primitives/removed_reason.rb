require 'flic/protocol/primitives'
require 'flic/protocol/primitives/enum'

module Flic
  module Protocol
    module Primitives
      # [:removed_by_this_client] The connection channel was removed by this client.
      # [:force_disconnected_by_this_client] The connection channel was removed due to a force disconnect by this client.
      # [:force_disconnected_by_other_client] Another client force disconnected the button used in this connection channel.
      # [:button_is_private] The button is not in public mode. Hold it down for 7 seconds while not trying to establish a connection, then try to reconnect by creating a new connection channel.
      # [:verify_timeout] After the connection was established, the bonding procedure didn't complete in time.
      # [:internet_backend_error] The internet request to the Flic backend failed.
      # [:invalid_data] According to the Flic backend, this Flic button supplied invalid identity data.
      class RemovedReason < Enum
        option :removed_by_this_client
        option :force_disconnected_by_this_client
        option :force_disconnected_by_other_client
        option :button_is_private
        option :verify_timeout
        option :internet_backend_error
        option :invalid_data
      end
    end
  end
end