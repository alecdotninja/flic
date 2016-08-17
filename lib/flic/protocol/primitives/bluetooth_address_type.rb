require 'flic/protocol/primitives'
require 'flic/protocol/primitives/enum'

module Flic
  module Protocol
    module Primitives
      # The server can be configured to either use the burnt-in public address stored inside the bluetooth controller, or to use a custom random static address. This custom address is a good idea if you want to be able to use your database with bonding information with a different bluetooth controller.
      # [:public_bluetooth_address_type] burnt-in public address
      # [:random_bluetooth_address_type] another address
      class BluetoothAddressType < Enum
        option :public_bluetooth_address_type
        option :random_bluetooth_address_type
      end
    end
  end
end