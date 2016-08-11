require 'fliclib'

require 'thread'

module Fliclib
  class EventBus
    class Error < StandardError; end
    class EventBusShutdown < Error; end

    autoload :Driver, 'fliclib/event_bus/driver'
    autoload :Subscription, 'fliclib/event_bus/subscription'

    def initialize
      @semaphore = Mutex.new
      @subscriptions = []
      @is_shutdown = false
    end

    def subscribe(subscription = Subscription.new)
      @semaphore.synchronize do
        raise EventBusShutdown if shutdown?

        @subscriptions << subscription
      end

      if block_given?
        begin
          yield subscription
        ensure
          unsubscribe subscription
        end
      end
    end

    def unsubscribe(subscription)
      @semaphore.synchronize do
        raise EventBusShutdown if shutdown?

        @subscriptions.delete subscription
      end

      subscription.destroy
    end

    def listen
      subscribe do |subscription|
        subscription.listen do
          yield
        end
      end
    end

    def broadcast(*args)
      @semaphore.synchronize do
        raise EventBusShutdown if shutdown?

        @subscriptions.each do |subscription|
          subscription.publish(*args)
        end
      end
    end

    def shutdown?
      @is_shutdown
    end

    def shutdown
      @semaphore.synchronize do
        unless shutdown?
          @is_shutdown = true

          @subscriptions.each do |subscription|
            subscription.destroy
          end

          @subscriptions.clear
        end
      end
    end
  end
end