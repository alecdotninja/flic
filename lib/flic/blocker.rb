require 'flic'

require 'thread'

module Flic
  class Blocker
    attr_reader :rejection_value

    def initialize
      @semaphore = Mutex.new
      @queues = []
      @rejection_value = nil
    end

    def block_until_callback
      queue = Queue.new

      begin
        @semaphore.synchronize do
          if @queues.frozen?
            raise *rejection_value
          else
            @queues << queue
          end
        end

        yield proc { |value| queue << [:resolve, value] }

        control, value = queue.pop

        case control
          when :resolve
            value
          when :reject
            raise *rejection_value
        end
      ensure
        @semaphore.synchronize do
          unless @queues.frozen?
            @queues.delete queue
          end
        end
      end
    end

    def unblock_all!(*rejection_value)
      @semaphore.synchronize do
        unless @queues.frozen?
          @rejection_value = rejection_value

          @queues.each { |queue| queue << [:reject, *rejection_value] }.clear
          @queues.freeze

          freeze
        end
      end
    end
  end
end