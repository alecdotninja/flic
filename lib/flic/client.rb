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
        Protocol::Events::PingResponse === event && event.ping_id == ping_id
      end
    end

    def get_info
      request Protocol::Commands::GetInfo, Protocol::Events::GetInfoResponse
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