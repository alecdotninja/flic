require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'
require 'fliclib/protocol/primitives/connection_status'
require 'fliclib/protocol/primitives/disconnect_reason'

module Fliclib
  module Protocol
    module Events
      class ConnectionStatusChanged < Event
        endian :little

        uint32 :connection_id
        connection_status :connection_status

        disconnect_reason :disconnect_reason    # only relevant when connection_status is :disconnected
      end
    end
  end
end
