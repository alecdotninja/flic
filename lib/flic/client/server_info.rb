require 'flic/client'

require 'struct'

module Flic
  class Client
    ServerInfo = Struct.new(
        'ServerInfo',
        :bluetooth_controller_state, :bluetooth_address,
        :bluetooth_address_type,
        :maximum_pending_connections,
        :maximum_concurrently_connected_buttons,
        :current_pending_connections,
        :currently_no_space_for_new_connection,
        :verified_buttons_bluetooth_addresses
    )
  end
end