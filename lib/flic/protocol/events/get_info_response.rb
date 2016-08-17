require 'flic/protocol/events'
require 'flic/protocol/events/event'
require 'flic/protocol/primitives/bluetooth_controller_state'
require 'flic/protocol/primitives/bluetooth_address'
require 'flic/protocol/primitives/bluetooth_address_type'

module Flic
  module Protocol
    module Events
      class GetInfoResponse < Event
        bluetooth_controller_state :bluetooth_controller_state
        bluetooth_address :bluetooth_address
        bluetooth_address_type :bluetooth_address_type

        uint8le :maximum_pending_connections
        int16le :maximum_concurrently_connected_buttons
        uint8le :current_pending_connections
        boolean :currently_no_space_for_new_connection

        uint16le :verified_buttons_bluetooth_addresses_length
        array :verified_buttons_bluetooth_addresses, type: :bluetooth_address, initial_length: :verified_buttons_bluetooth_addresses_length
      end
    end
  end
end

