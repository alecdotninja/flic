require 'flic/protocol/events'
require 'flic/protocol/events/event'

module Flic
  module Protocol
    module Events
      class ScanWizardButtonConnected < Event
        endian :little

        uint32 :scan_wizard_id
      end
    end
  end
end
