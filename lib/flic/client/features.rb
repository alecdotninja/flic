require 'flic/client'

module Flic
  class Client
    module Features
      autoload :ConnectionChannel, 'flic/client/features/connection_channel'
      autoload :ForceDisconnect, 'flic/client/features/force_disconnect'
      autoload :GetButtonUuid, 'flic/client/features/get_button_uuid'
      autoload :GetInfo, 'flic/client/features/get_info'
      autoload :Ping, 'flic/client/features/ping'
      autoload :Scan, 'flic/client/features/scan'
      autoload :ScanWizard, 'flic/client/features/scan_wizard'
    end
  end
end