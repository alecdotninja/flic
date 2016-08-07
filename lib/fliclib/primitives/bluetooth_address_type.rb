require 'fliclib/enum'

require 'bindata'

module Fliclib
  module Primitives
    class BluetoothAddressType < BinData::Primitive
      include Enum

      option :public_bluetooth_address_type
      option :random_bluetooth_address_type
    end
  end
end