require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'

module Fliclib
  module Protocol
    module Events
      class ScanWizardButtonConnected < Event
        endian :little

        uint32 :scan_wizard_id
      end
    end
  end
end
