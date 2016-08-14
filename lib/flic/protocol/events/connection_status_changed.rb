require 'flic/protocol/events'
require 'flic/protocol/events/event'
require 'flic/protocol/primitives/connection_status'
require 'flic/protocol/primitives/disconnect_reason'

module Flic
  module Protocol
    module Events
      class ConnectionStatusChanged < Event
        endian :little

        uint32 :connection_channel_id
        connection_status :connection_status

        disconnect_reason :disconnect_reason    # only relevant when connection_status is :disconnected
      end
    end
  end
end
