require 'flic/client/features'

require 'thread'

module Flic
  class Client
    module Features
      module Ping
        def initialize(*)
          @ping_id_callback_semaphore = Mutex.new
          @ping_id_callback = {}

          super
        end

        def ping(callback = Proc.new)
          ping_id = alloc_ping_id_with_callback(callback)

          send_command Protocol::Commands::Ping.new(ping_id: ping_id)
        end

        private

        def alloc_ping_id_with_callback(callback)
          @ping_id_callback_semaphore.synchronize do
            ping_id = nil

            loop do
              ping_id = rand(2**32)

              break unless @ping_id_callback.has_key?(ping_id)
            end

            @ping_id_callback[ping_id] = callback

            ping_id
          end
        end

        def handle_event(event)
          case event
            when Protocol::Events::PingResponse
              callback = @ping_id_callback_semaphore.synchronize do
                @ping_id_callback.delete event.ping_id
              end

              callback.call if callback
            else
              super
          end
        end
      end
    end
  end
end