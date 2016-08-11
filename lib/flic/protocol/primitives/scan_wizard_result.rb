require 'flic/protocol/primitives'
require 'flic/protocol/primitives/enum'

module Flic
  module Protocol
    module Primitives
      class ScanWizardResult < Enum
        option :success                 # Indicates that a button was successfully paired and verified. You may now create a connection channel to that button.
        option :cancelled_by_user       # A CmdCancelScanWizard was sent.
        option :timeout                 # The scan wizard did not make any progress for some time. Current timeouts are 20 seconds for finding any button, 20 seconds for finding a public button (in case of a private button was found), 10 seconds for connecting the button, 30 seconds for pairing and verifying the button.
        option :button_private          # First the button was advertising public status, but after connecting it reports private. Probably it switched from public to private just when the connection attempt was started.
        option :bluetooth_unavailable   # The bluetooth controller is not attached.
        option :internet_backend_error  # The internet request to the Flic backend failed.
        option :invalid_data            # According to the Flic backend, this Flic button supplied invalid identity data.
      end
    end
  end
end