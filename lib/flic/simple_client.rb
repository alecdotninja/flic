require 'flic'

require 'thread'

module Flic
  class SimpleClient
    class Error < StandardError; end
    class ConnectionChannelRemoved; end

    attr_reader :client

    def initialize(*client_args)
      @client = Client.new(*client_args)
    end

    def shutdown
      client.shutdown
    end

    def buttons
      server_info = process_events_until do |callback|
        client.get_info(&callback)
      end

      server_info.verified_buttons_bluetooth_addresses
    end

    def connect_button
      begin
        scan_wizard = Client::ScanWizard.new

        process_events_until do |callback|
          scan_wizard.removed do |result, bluetooth_address, *|
            if result == :success
              callback.call(bluetooth_address)
            else
              callback.call(nil)
            end
          end

          client.add_scan_wizard(scan_wizard)
        end
      ensure
        client.remove_scan_wizard(scan_wizard)
      end
    end

    def disconnect_button(button_bluetooth_address)
      client.force_disconnect(button_bluetooth_address)
    end

    def listen(latency_mode, *button_bluetooth_addresses)
      connection_channels = []
      button_events = []
      broken = false

      begin
        button_bluetooth_addresses.each do |button_bluetooth_addresses|
          connection_channel = Client::ConnectionChannel.new(button_bluetooth_addresses, latency_mode)

          connection_channel.button_up_or_down do |click_type, latency|
            button_events << [button_bluetooth_addresses, click_type, latency]
          end

          connection_channel.button_single_click_or_double_click_or_hold do |click_type, latency|
            button_events << [button_bluetooth_addresses, click_type, latency]
          end

          connection_channel.removed do
            broken = true
          end

          connection_channels << connection_channel

          client.add_connection_channel connection_channel
        end


        loop do
          client.handle_next_event while !broken && button_events.empty?

          button_events.each do |button_event|
            yield *button_event
          end

          button_events.clear

          raise ConnectionChannelRemoved, 'A connection channel was removed' if broken
        end
      ensure
        connection_channels.each do |connection_channel|
          client.remove_connection_channel connection_channel
        end
      end
    end

    private

    def process_events_until
      done = false
      result = nil

      callback = proc do |_result|
        done = true
        result = _result
      end

      yield callback

      client.handle_next_event until done

      result
    end
  end
end