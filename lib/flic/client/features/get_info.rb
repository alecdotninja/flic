require 'flic/client/features'

require 'thread'

module Flic
  class Client
    module Features
      module GetInfo
        def initialize(*)
          @get_info_callbacks_semaphore = Mutex.new
          @get_info_callbacks = []

          super
        end

        def get_info(callback = Proc.new)
          @get_info_callbacks_semaphore.synchronize do
            @get_info_callbacks << callback
          end

          send_command Protocol::Commands::GetInfo.new
        end

        private

        def handle_event(event)
          case event
            when Protocol::Events::GetInfoResponse
              server_info = ServerInfo.new(
                  event.bluetooth_controller_state,
                  event.bluetooth_address,
                  event.bluetooth_address_type,
                  event.maximum_pending_connections,
                  event.maximum_concurrently_connected_buttons,
                  event.current_pending_connections,
                  event.currently_no_space_for_new_connection,
                  event.verified_buttons_bluetooth_addresses
              )

              callback = @get_info_callbacks_semaphore.synchronize do
                @get_info_callbacks.shift
              end

              callback.call server_info if callback
            else
              super
          end
        end
      end
    end
  end
end
