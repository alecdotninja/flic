require 'fliclib/events'
require 'fliclib/events/event'
require 'fliclib/primitives/bluetooth_address'
require 'fliclib/primitives/device_name'
require 'fliclib/primitives/boolean'

module Fliclib
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
