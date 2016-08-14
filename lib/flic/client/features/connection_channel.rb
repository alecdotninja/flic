require 'flic/client/features'

require 'thread'

module Flic
  class Client
    module Features
      module ConnectionChannel
        def initialize(*)
          @connection_channel_id_connection_channel_semaphore = Mutex.new
          @connection_channel_id_connection_channel = {}

          super
        end

        def connection_channels
          @connection_channel_id_connection_channel_semaphore.synchronize { @connection_channel_id_connection_channel.values }
        end

        def add_connection_channel(connection_channel)
          connection_channel_id = _add_connection_channel(connection_channel)

          if connection_channel_id
            send_command Protocol::Commands::CreateConnectionChannel.new(
                connection_channel_id: connection_channel_id,
                bluetooth_address: connection_channel.button_bluetooth_address,
                latency_mode: connection_channel.latency_mode,
                auto_disconnect_time: connection_channel.auto_disconnect_time
            )
          end
        end

        def remove_connection_channel(connection_channel)
          connection_channel_id = find_connection_channel_id_by_connection_channel(connection_channel)

          if connection_channel_id
            send_command Protocol::Commands::RemoveConnectionChannel.new(
                connection_channel_id: connection_channel_id
            )
          end
        end

        def shutdown(*)
          connection_channels.each do |connection_channel|
            _remove_connection_channel(connection_channel)
            connection_channel.removed self
          end

          super
        end

        private

        def handle_event(event)
          case event
            when Protocol::Events::CreateConnectionChannelResponse
              connection_channel = find_connection_channel_by_connection_channel_id(event.connection_channel_id)

              if connection_channel
                if event.error == :no_error
                  connection_channel.added self
                else
                  _remove_connection_channel(connection_channel)
                  connection_channel.failed_to_add self, event.error
                end
              end

            when Protocol::Events::ConnectionStatusChanged
              connection_channel = find_connection_channel_by_connection_channel_id(event.connection_channel_id)

              if connection_channel
                connection_channel.status = event.connection_status
                connection_channel.status_changed event.connection_status
              end

            when Protocol::Events::ButtonUpOrDown
              connection_channel = find_connection_channel_by_connection_channel_id(event.connection_channel_id)

              if connection_channel
                connection_channel.button_up_or_down event.click_type, event.time_difference, event.was_queued
              end
            when Protocol::Events::ButtonClickOrHold
              connection_channel = find_connection_channel_by_connection_channel_id(event.connection_channel_id)

              if connection_channel
                connection_channel.button_click_or_hold event.click_type, event.time_difference, event.was_queued
              end

            when Protocol::Events::ButtonSingleOrDoubleClick
              connection_channel = find_connection_channel_by_connection_channel_id(event.connection_channel_id)

              if connection_channel
                connection_channel.button_single_click_or_double_click event.click_type, event.time_difference, event.was_queued
              end

            when Protocol::Events::ButtonSingleOrDoubleClickOrHold
              connection_channel = find_connection_channel_by_connection_channel_id(event.connection_channel_id)

              if connection_channel
                connection_channel.button_single_click_or_double_click_or_hold event.click_type, event.time_difference, event.was_queued
              end

            when Protocol::Events::ConnectionChannelRemoved
              connection_channel = find_connection_channel_by_connection_channel_id(event.connection_channel_id)

              if connection_channel
                _remove_connection_channel(connection_channel)
                connection_channel.removed self, event.reason
              end

            else
              super
          end
        end

        def find_connection_channel_by_connection_channel_id(needle)
          @connection_channel_id_connection_channel_semaphore.synchronize do
            @connection_channel_id_connection_channel.each do |connection_channel_id, connection_channel|
              return connection_channel if connection_channel_id == needle
            end
          end

          nil
        end

        def find_connection_channel_id_by_connection_channel(needle)
          @connection_channel_id_connection_channel_semaphore.synchronize do
            @connection_channel_id_connection_channel.each do |connection_channel_id, connection_channel|
              return connection_channel_id if connection_channel == needle
            end
          end

          nil
        end

        def _add_connection_channel(connection_channel)
          connection_channel_id = nil

          @connection_channel_id_connection_channel_semaphore.synchronize do
            unless @connection_channel_id_connection_channel.values.include?(connection_channel)
              loop do
                connection_channel_id = rand(2**32)

                break unless @connection_channel_id_connection_channel.has_key?(connection_channel_id)
              end

              @connection_channel_id_connection_channel[connection_channel_id] = connection_channel
            end
          end

          connection_channel_id
        end

        def _remove_connection_channel(connection_channel)
          connection_channel_id = nil

          @connection_channel_id_connection_channel_semaphore.synchronize do
            if @connection_channel_id_connection_channel.values.include?(connection_channel)
              @connection_channel_id_connection_channel.each do |_connection_channel_id, _connection_channel|
                if connection_channel == _connection_channel
                  connection_channel_id = _connection_channel_id
                  break
                end
              end

              @connection_channel_id_connection_channel.delete connection_channel_id if connection_channel_id
            end
          end

          connection_channel_id
        end
      end
    end
  end
end