require 'flic/client'

module Flic
  class Client
    class ConnectionChannel
      extend Callbacks

      attr_reader :button_bluetooth_address, :latency_mode, :auto_disconnect_time
      attr_accessor :status

      define_callbacks :added, :removed, :failed_to_add, :status_changed,
                       :button_up_or_down, :button_click_or_hold,
                       :button_single_click_or_double_click, :button_single_click_or_double_click_or_hold

      def initialize(button_bluetooth_address, latency_mode, auto_disconnect_time = nil)
        @button_bluetooth_address, @latency_mode, @auto_disconnect_time = button_bluetooth_address, latency_mode, auto_disconnect_time
        @status = :disconnected
      end
    end
  end
end