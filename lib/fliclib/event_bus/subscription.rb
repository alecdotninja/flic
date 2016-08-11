require 'fliclib/event_bus'

require 'thread'

module Fliclib
  class EventBus
    class Subscription
      class SubscriptionDestroyed < Error
      end

      def initialize
        @queue = Queue.new
        @semaphore = Mutex.new
        @is_destroyed = false
      end

      def listen
        loop do
          yield *next_event!
        end
      end

      def next_event_nonblock
        next_event unless @queue.empty?
      end

      def next_event
        @semaphore.synchronize do
          unless destroyed?
            control, event = @queue.pop

            case control
              when :event
                event
              when :destroy
                @is_destroyed = true

                nil
              else
                raise NotImplementedError
            end
          end
        end
      end

      def next_event!
        event = next_event
        raise SubscriptionDestroyed if destroyed?
        event
      end

      def publish(*args)
        raise SubscriptionDestroyed if destroyed?
        @queue.push [:event, *args]
      end

      def destroyed?
        @is_destroyed
      end

      def destroy
        @queue.push [:destroy] unless destroyed?
      end
    end
  end
end
