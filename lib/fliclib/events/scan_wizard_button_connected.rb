require 'fliclib/events'
require 'fliclib/events/event'

module Fliclib
  module Events
    class ScanWizardButtonConnected < Event
      endian :little

      uint32 :scan_wizard_id
    end
  end
end
