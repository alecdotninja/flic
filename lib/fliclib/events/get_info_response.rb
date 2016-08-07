require 'fliclib/events'
require 'fliclib/events/event'
require 'fliclib/primitives/bluetooth_controller_state'
require 'fliclib/primitives/bluetooth_address'
require 'fliclib/primitives/bluetooth_address_type'

module Fliclib
  module Events
    class GetInfoResponse < Event
      endian :little

      bluetooth_controller_state :bluetooth_controller_state
      bluetooth_address :bluetooth_address
      bluetooth_address_type :bluetooth_address_type

      uint8 :maximum_pending_connections
      int16 :maximum_concurrently_connected_buttons
      uint8 :current_pending_connections
      boolean :currently_no_space_for_new_connection

      uint16 :verified_buttons_length
      array :verified_buttons, type: :bluetooth_address, initial_length: :verified_buttons_length
    end
  end
end
