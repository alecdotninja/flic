require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'
require 'fliclib/protocol/primitives/bluetooth_address'
require 'fliclib/protocol/primitives/device_name'
require 'fliclib/protocol/primitives/boolean'

module Fliclib
  module Protocol
    module Events
      class AdvertisementPacket < Event
        endian :little

        uint32 :scan_id
        bluetooth_address :address

        device_name :name

        int8 :rssi

        boolean :is_private
        boolean :is_already_verified
      end
    end
  end
end
