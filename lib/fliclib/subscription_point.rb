require 'fliclib'

require 'thread'

module Fliclib
  class SubscriptionPoint
    class Error < StandardError
    end

    class SubscriptionPointDestroyed < Error
    end

    class Subscription
      def listen
        loop do
          control, *args = queue.pop

          case control
            when :yield
              yield *args
            when :raise
              raise *args
            else
              raise NotImplementedError
          end
        end
      end

      def queue
        @queue ||= Queue.new
      end
    end

    def subscribe
      subscription = Subscription.new
      queue = subscription.queue

      register_queue(queue)

      begin
        yield subscription
      ensure
        unregister_queue(queue)
      end
    end

    def listen
      subscribe do |subscription|
        subscription.listen do
          yield
        end
      end
    end

    def broadcast(*args)
      semaphore.synchronize do
        queues.each do |queue|
          queue.push [:yield, *args]
        end
      end
    end

    def destroy
      semaphore.synchronize do
        queues.each do |queue|
          queue.push [:raise, SubscriptionPointDestroyed.new]
        end
      end
    end

    private

    def register_queue(queue)
      semaphore.synchronize do
        queues << queue
      end
    end

    def unregister_queue(queue)
      semaphore.synchronize do
        queues.delete queue
      end
    end

    def queues
      @queues ||= []
    end

    def semaphore
      @semaphore ||= Mutex.new
    end
  end
end