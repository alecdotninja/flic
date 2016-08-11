require 'fliclib/protocol/primitives'
require 'fliclib/protocol/primitives/enum'

module Fliclib
  module Protocol
    module Primitives
      class BluetoothAddressType < Enum
        option :public_bluetooth_address_type
        option :random_bluetooth_address_type
      end
    end
  end
end