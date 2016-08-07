require 'fliclib/commands'
require 'fliclib/commands/command'
require 'fliclib/primitives/bluetooth_address'

module Fliclib
  module Commands
    class CreateScanWizard < Command
      endian :little

      uint32 :scan_wizard_id
    end
  end
end
