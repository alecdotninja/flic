require 'flic/protocol/events'
require 'flic/protocol/events/event'
require 'flic/protocol/primitives/bluetooth_address'
require 'flic/protocol/primitives/device_name'
require 'flic/protocol/primitives/boolean'

module Flic
  module Protocol
    module Events
      class AdvertisementPacket < Event
        uint32le :scan_id
        bluetooth_address :bluetooth_address

        device_name :name

        int8le :rssi

        boolean :is_private
        boolean :is_already_verified
      end
    end
  end
end
