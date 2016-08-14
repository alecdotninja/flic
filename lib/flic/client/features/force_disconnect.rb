require 'flic/client/features'

module Flic
  class Client
    module Features
      module ForceDisconnect
        def force_disconnect(button_bluetooth_address)
          send_command Protocol::Commands::ForceDisconnect.new(bluetooth_address: button_bluetooth_address)
        end
      end
    end
  end
end