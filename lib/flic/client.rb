require 'flic'

require 'thread'
require 'socket'

module Flic
  class Client
    class Error < StandardError; end
    class ClientShutdownError < Error; end

    autoload :ConnectionChannel, 'flic/client/connection_channel'
    autoload :Features, 'flic/client/features'
    autoload :ScanWizard, 'flic/client/scan_wizard'
    autoload :Scanner, 'flic/client/scanner'
    autoload :ServerInfo, 'flic/client/server_info'

    extend Callbacks

    prepend Features::ConnectionChannel
    prepend Features::ForceDisconnect
    prepend Features::GetButtonUuid
    prepend Features::GetInfo
    prepend Features::Ping
    prepend Features::Scan
    prepend Features::ScanWizard

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

    attr_reader :host, :port, :socket, :connection

    define_callbacks :new_button_verified, :bluetooth_controller_state_changed,
                     :connections_exhausted, :connection_available


    def initialize(host = 'localhost', port = 5551)
      @host, @port = host, port
      @handle_next_event_semaphore = Mutex.new
      @socket = TCPSocket.new(host, port)
      @connection = Protocol::Connection.new(socket)
      yield self if block_given?
    end

    def shutdown
      connection.close
    end

    def handle_next_event
      @handle_next_event_semaphore.synchronize do
        begin
          handle_event connection.recv_event
        rescue Protocol::Connection::ConnectionClosedError
          shutdown

          raise ClientShutdownError, 'The connection has been closed'
        end
      end
    end

    def enter_main_loop
      loop { handle_next_event }
    end

    private

    def send_command(command)
      connection.send_command(command)
    rescue Protocol::Connection::ConnectionClosedError
      shutdown

      raise ClientShutdownError, 'The connection has been closed'
    end

    def handle_event(event)
      case event
        when Protocol::Events::NewVerifiedButton
          new_button_verified event.bluetooth_address
        when Protocol::Events::BluetoothControllerStateChange
          bluetooth_controller_state_changed event.bluetooth_controller_state
        when Protocol::Events::NoSpaceForNewConnection
          connections_exhausted
        when Protocol::Events::GotSpaceForNewConnection
          connection_available
      end
    end
  end
end
