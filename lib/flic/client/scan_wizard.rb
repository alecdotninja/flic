require 'flic/client'

module Flic
  class Client
    class ScanWizard
      extend Callbacks

      attr_accessor :button_bluetooth_address, :button_name, :result

      define_callbacks :added, :removed,
                       :found_private_button, :found_public_button, :button_connected

      def successful?
        result == :success
      end
    end
  end
end