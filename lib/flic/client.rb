require 'flic'
require 'flic/event_bus'
require 'flic/protocol'

module Flic
  class Client
    autoload :Connection, 'flic/client/connection'

    class Error < StandardError; end
    class ClientShutdownError < Error; end

    class << self
      def open(*args)
        client = new(*args)

        begin
          yield client
        ensure
          client.shutdown
        end
      end
    end

    attr_reader :connection, :driver

    def initialize(*connection_args)
      @connection = Connection.new(*connection_args)

      @driver = EventBus::Driver.new do |event_bus|
        begin
          connection.listen do |event|
            event_bus.broadcast(event)
          end
        rescue Connection::ConnectionClosedError
          nil
        rescue Protocol::Error => protocol_error
          warn protocol_error

          retry
        end
      end

      yield self if block_given?
    end

    def hostname
      connection.hostname
    end

    def port
      connection.port
    end

    def shutdown?
      connection.closed?
    end

    def shutdown
      connection.close
    end

    def ping ping_id = rand(2**32)
      request Protocol::Commands::Ping.new(ping_id: ping_id) do |event|
        Protocol::Events::PingResponse === event &&
            event.ping_id == ping_id
      end

      true
    end

    def server_info
      request Protocol::Commands::GetInfo, Protocol::Events::GetInfoResponse
    end

    def button_uuid(bluetooth_address)
      command = Protocol::Commands::GetButtonUuid.new(bluetooth_address: bluetooth_address)

      response = request command do |event|
        Protocol::Events::GetButtonUuidResponse === event &&
            event.bluetooth_address == command.bluetooth_address
      end

      unless response.uuid == Protocol::INVALID_BUTTON_UUID
        response.uuid
      end
    end

    def buttons
      server_info.verified_buttons
    end

    def disconnect_button(bluetooth_address)
      send_command Protocol::Commands::ForceDisconnect.new(bluetooth_address: bluetooth_address)
    end

    def connect_button
      bluetooth_address = nil

      result = scan_wizard do |button_type, _bluetooth_address|
        bluetooth_address = _bluetooth_address if button_type == :public
      end

      bluetooth_address if result == :success
    end

    def scan(scan_id = rand(2**32))
      subscribe do |subscription|
        send_command Protocol::Commands::CreateScanner.new(scan_id: scan_id)

        begin
          subscription.listen do |event|
            if Protocol::Events::AdvertisementPacket === event && event.scan_id == scan_id
              yield event.bluetooth_address, event.name, event.rssi, event.is_private, event.is_already_verified
            end
          end
        ensure
          send_command Protocol::Commands::RemoveScanner.new(scan_id: scan_id)
        end
      end
    end

    def scan_wizard(scan_wizard_id = rand(2**32))
      subscribe do |subscription|
        send_command Protocol::Commands::CreateScanWizard.new(scan_wizard_id: scan_wizard_id)

        begin
          bluetooth_address = nil
          name = nil

          result = subscription.listen do |event|
            case event
              when Protocol::Events::ScanWizardFoundPrivateButton
                yield :private, nil, nil
              when Protocol::Events::ScanWizardFoundPublicButton
                bluetooth_address, name = event.bluetooth_address, event.name
              when Protocol::Events::ScanWizardButtonConnected
                yield :public, bluetooth_address, name
              when Protocol::Events::ScanWizardCompleted
                break event.scan_wizard_result
            end
          end
        ensure
          send_command Protocol::Commands::CancelScanWizard.new(scan_wizard_id: scan_wizard_id) unless result
        end
      end
    end

    private

    def event_bus
      @event_bus ||= driver.event_bus
    end

    def send_command(command)
      command = command.new if Class === command
      connection.send_command(command)
    rescue Client::Connection::ConnectionClosedError
      raise ClientShutdownError
    end

    def subscribe
      event_bus.subscribe { |subscription| yield subscription }
    rescue EventBus::EventBusShutdown
      raise ClientShutdownError
    end

    def request(command, response_matcher = Proc.new)
      subscribe do |subscription|
        send_command command

        subscription.listen do |event|
          if response_matcher === event
            break event
          end
        end
      end
    end
  end
end