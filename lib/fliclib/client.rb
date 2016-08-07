require 'fliclib'
require 'fliclib/raw_client'
require 'fliclib/subscription_point'

require 'thread'

module Fliclib
  class Client
    class << self
      def open(*args)
        client = new(*args)

        begin
          yield client
        ensure
          client.close
        end
      end
    end

    attr_reader :raw_client, :event_thread, :subscription_point

    def initialize(*args)
      @raw_client = RawClient.new(*args)

      @subscription_point = SubscriptionPoint.new

      @event_thread = Thread.new do
        begin
          raw_client.listen do |event|
            subscription_point.broadcast(event)
          end
        ensure
          subscription_point.destroy
        end
      end

      yield self if block_given?
    end

    def closed?
      raw_client.closed?
    end

    def close
      unless closed?
        raw_client.close
        event_thread.exit
        event_thread.join
      end
    end

    def ping ping_id = rand(2**32)
      ping = Commands::Ping.new(ping_id: ping_id)

      subscription_point.subscribe do |subscription|
        send_command ping

        subscription.listen do |event|
          if Events::PingResponse === event && event.ping_id == ping_id
            break event
          end
        end
      end
    end

    private

    def send_command(*args)
      raw_client.send_command(*args)
    end
  end
end