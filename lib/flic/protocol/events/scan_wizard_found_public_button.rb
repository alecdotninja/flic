require 'flic/protocol/events'
require 'flic/protocol/events/event'
require 'flic/protocol/primitives/bluetooth_address'
require 'flic/protocol/primitives/device_name'

module Flic
  module Protocol
    module Events
      class ScanWizardFoundPublicButton < Event
        endian :little

        uint32 :scan_wizard_id

        bluetooth_address :bluetooth_address
        device_name :name
      end
    end
  end
end
