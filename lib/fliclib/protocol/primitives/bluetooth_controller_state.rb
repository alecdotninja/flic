require 'fliclib/protocol/primitives'
require 'fliclib/protocol/primitives/enum'

module Fliclib
  module Protocol
    module Primitives
      class BluetoothControllerState < Enum
        option :detached      # The server software has lost the HCI socket to the bluetooth controller and is trying to reconnect.
        option :resetting     # The server software has just got connected to the HCI socket and initiated a reset of the bluetooth controller.
        option :attached      # The bluetooth controller has done initialization and is up and running.
      end
    end
  end
end