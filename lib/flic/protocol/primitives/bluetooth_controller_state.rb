require 'flic/protocol/primitives'
require 'flic/protocol/primitives/enum'

module Flic
  module Protocol
    module Primitives
      # The server software detects when the bluetooth controller is removed or is made unavailable. It will then repeatedly retry to re-established a connection to the same bluetooth controller.
      # [:detached] The server software has lost the HCI socket to the bluetooth controller and is trying to reconnect.
      # [:resetting] The server software has just got connected to the HCI socket and initiated a reset of the bluetooth controller.
      # [:attached] The bluetooth controller has done initialization and is up and running.
      class BluetoothControllerState < Enum
        option :detached
        option :resetting
        option :attached
      end
    end
  end
end