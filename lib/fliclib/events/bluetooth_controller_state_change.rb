require 'fliclib/events'
require 'fliclib/events/event'
require 'fliclib/primitives/bluetooth_controller_state'

module Fliclib
  module Events
    class BluetoothControllerStateChange < Event
      endian :little

      bluetooth_controller_state :bluetooth_controller_state
    end
  end
end
