require 'flic/protocol/events'
require 'flic/protocol/events/event'
require 'flic/protocol/primitives/scan_wizard_result'

module Flic
  module Protocol
    module Events
      class ScanWizardCompleted < Event
        uint32le :scan_wizard_id
        scan_wizard_result :scan_wizard_result
      end
    end
  end
end
