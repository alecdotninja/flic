require 'fliclib/protocol/commands'
require 'fliclib/protocol/commands/command'
require 'fliclib/protocol/primitives/bluetooth_address'

module Fliclib
  module Protocol
    module Commands
      class CreateScanWizard < Command
        endian :little

        uint32 :scan_wizard_id
      end
    end
  end
end
