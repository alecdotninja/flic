require 'fliclib/events'
require 'fliclib/events/event'
require 'fliclib/primitives/connection_status'
require 'fliclib/primitives/disconnect_reason'

module Fliclib
  module Events
    class ConnectionStatusChanged < Event
      endian :little

      uint32 :connection_id
      connection_status :connection_status

      disconnect_reason :disconnect_reason    # only relevant when connection_status is :disconnected
    end
  end
end
