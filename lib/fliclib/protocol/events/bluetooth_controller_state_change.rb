require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'
require 'fliclib/protocol/primitives/bluetooth_controller_state'

module Fliclib
  module Protocol
    module Events
      class BluetoothControllerStateChange < Event
        endian :little

        bluetooth_controller_state :bluetooth_controller_state
      end
    end
  end
end
