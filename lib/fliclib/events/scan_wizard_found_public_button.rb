require 'fliclib/events'
require 'fliclib/events/event'
require 'fliclib/primitives/bluetooth_address'
require 'fliclib/primitives/device_name'

module Fliclib
  module Events
    class ScanWizardFoundPublicButton < Event
      endian :little

      uint32 :scan_wizard_id

      bluetooth_address :bluetooth_address
      uint8 :name_length
      device_name :name
    end
  end
end
