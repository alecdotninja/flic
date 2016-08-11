require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'
require 'fliclib/protocol/primitives/scan_wizard_result'

module Fliclib
  module Protocol
    module Events
      class ScanWizardCompleted < Event
        endian :little

        uint32 :scan_wizard_id
        scan_wizard_result :scan_wizard_result
      end
    end
  end
end
