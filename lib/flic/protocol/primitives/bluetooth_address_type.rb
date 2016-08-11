require 'flic/protocol/primitives'
require 'flic/protocol/primitives/enum'

module Flic
  module Protocol
    module Primitives
      class BluetoothAddressType < Enum
        option :public_bluetooth_address_type
        option :random_bluetooth_address_type
      end
    end
  end
end