require 'flic/event_bus'

require 'thread'

module Flic
  class EventBus
    class Driver < Thread
      attr_reader :event_bus

      def initialize
        @event_bus = EventBus.new

        super() do
          begin
            yield(event_bus)
          ensure
            event_bus.shutdown
          end
        end
      end
    end
  end
end