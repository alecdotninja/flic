require 'flic/client/features'

require 'thread'

module Flic
  class Client
    module Features
      module GetButtonUuid
        def initialize(*)
          @button_bluetooth_address_callbacks_semaphore = Mutex.new
          @button_bluetooth_address_callbacks = Hash.new { [] }

          super
        end

        def get_button_uuid(button_bluetooth_address, callback = Proc.new)
          command = Protocol::Commands::GetButtonUuid.new(bluetooth_address: button_bluetooth_address)

          @button_bluetooth_address_callbacks_semaphore.synchronize do
            @button_bluetooth_address_callbacks[command.bluetooth_address] << callback
          end

          send_command command
        end

        private

        def handle_event(event)
          case event
            when Protocol::Events::GetButtonUuidResponse
              callback = @button_bluetooth_address_callbacks_semaphore.synchronize do
                @button_bluetooth_address_callbacks[event.bluetooth_address].shift
              end

              callback.call event.uuid if callback
            else
              super
          end
        end
      end
    end
  end
end