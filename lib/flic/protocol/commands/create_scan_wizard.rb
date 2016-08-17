require 'flic/protocol/commands'
require 'flic/protocol/commands/command'
require 'flic/protocol/primitives/bluetooth_address'

module Flic
  module Protocol
    module Commands
      class CreateScanWizard < Command
        uint32le :scan_wizard_id
      end
    end
  end
end
