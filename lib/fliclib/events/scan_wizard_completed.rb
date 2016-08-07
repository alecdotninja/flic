require 'fliclib/events'
require 'fliclib/events/event'
require 'fliclib/primitives/scan_wizard_result'

module Fliclib
  module Events
    class ScanWizardCompleted < Event
      endian :little

      uint32 :scan_wizard_id
      scan_wizard_result :scan_wizard_result
    end
  end
end
