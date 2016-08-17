require 'flic/protocol/events'
require 'flic/protocol/events/event'
require 'flic/protocol/primitives/bluetooth_controller_state'

module Flic
  module Protocol
    module Events
      class BluetoothControllerStateChange < Event
        bluetooth_controller_state :bluetooth_controller_state
      end
    end
  end
end
