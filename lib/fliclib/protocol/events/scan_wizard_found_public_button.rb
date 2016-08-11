require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'
require 'fliclib/protocol/primitives/bluetooth_address'
require 'fliclib/protocol/primitives/device_name'

module Fliclib
  module Protocol
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
end
