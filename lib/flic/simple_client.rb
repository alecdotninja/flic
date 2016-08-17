require 'flic'

require 'thread'

module Flic
  class SimpleClient
    class Error < StandardError; end
    class Shutdown < Error; end
    class ConnectionChannelRemoved < Error; end
    class ButtonIsPrivateError < Error; end

    attr_reader :host, :port, :thread

    def initialize(host = 'localhost', port = 5551)
      @host, @port = host, port
      
      @blocker = Blocker.new
      @client = Client.new(host, port)

      @listen_queues_semaphore = Mutex.new
      @listen_queues = []

      @thread = Thread.new do
        begin
          @client.enter_main_loop
        rescue Client::Shutdown
            nil
        ensure
          shutdown
        end
      end

      @is_shutdown = false
    end

    def shutdown?
      @is_shutdown
    end

    def shutdown
      @listen_queues_semaphore.synchronize do
        unless @listen_queues.frozen?
          @listen_queues.each { |queue| queue << :shutdown }.clear
          @listen_queues.freeze
        end
      end

      @blocker.unblock_all! Shutdown, 'The client has shutdown'

      @client.shutdown

      @thread.join unless Thread.current == @thread

      @is_shutdown = true
    end

    def buttons
      @blocker.block_until_callback do |callback|
        @client.get_info do |server_info|
          callback.call server_info.verified_buttons_bluetooth_addresses
        end
      end
    rescue Client::Shutdown
      raise  Shutdown, 'The client has shutdown'
    end

    def connect_button
      scan_wizard = Client::ScanWizard.new
      saw_only_private_button = false

      begin
        @blocker.block_until_callback do |callback|
          scan_wizard.found_private_button do
            saw_only_private_button = true
          end

          scan_wizard.found_public_button do
            saw_only_private_button = false
          end

          scan_wizard.removed do
            callback.call
          end

          @client.add_scan_wizard(scan_wizard)
        end
      ensure
        @client.remove_scan_wizard(scan_wizard)
      end

      if scan_wizard.successful?
        scan_wizard.button_bluetooth_address
      elsif saw_only_private_button
        raise ButtonIsPrivateError, 'A button was found, but it is private. Press and hold the button for 7 seconds to make it public and try again.'
      end
    rescue Client::Shutdown
      raise  Shutdown, 'The client has shutdown'
    end

    def disconnect_button(button_bluetooth_address)
      @client.force_disconnect(button_bluetooth_address)
    rescue Client::Shutdown
      raise  Shutdown, 'The client has shutdown'
    end

    def listen(button_bluetooth_address_or_latency_mode, *button_bluetooth_addresses)
      if Symbol === button_bluetooth_address_or_latency_mode
        latency_mode = button_bluetooth_address_or_latency_mode
      else
        latency_mode = :normal
        button_bluetooth_addresses.unshift button_bluetooth_address_or_latency_mode
      end

      connection_channels = []
      queue = Queue.new

      @listen_queues_semaphore.synchronize { @listen_queues << queue }

      begin
        button_bluetooth_addresses.each do |button_bluetooth_addresses|
          connection_channel = Client::ConnectionChannel.new(button_bluetooth_addresses, latency_mode)

          connection_channel.button_up_or_down do |click_type, latency|
            queue << [:button_interaction, button_bluetooth_addresses, click_type, latency]
          end

          connection_channel.button_single_click_or_double_click_or_hold do |click_type, latency|
            queue << [:button_interaction, button_bluetooth_addresses, click_type, latency]
          end

          connection_channel.removed do
            queue << [:connection_channel_removed, connection_channel]
          end

          connection_channels << connection_channel

          @client.add_connection_channel connection_channel
        end

        loop do
          event_type, *params = queue.pop

          case event_type
            when :button_interaction
              yield *params
            when :connection_channel_removed
              raise ConnectionChannelRemoved, 'A connection channel was removed'
            when :shutdown
              raise  Shutdown, 'The client has shutdown'
          end
        end
      ensure
        connection_channels.each do |connection_channel|
          @client.remove_connection_channel connection_channel
        end

        @listen_queues_semaphore.synchronize { @listen_queues.delete queue unless @listen_queues.frozen? }
      end
    rescue Client::Shutdown
      raise  Shutdown, 'The client has shutdown'
    end
  end
end