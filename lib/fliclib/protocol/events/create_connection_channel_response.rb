require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'
require 'fliclib/protocol/primitives/create_connection_channel_error'
require 'fliclib/protocol/primitives/connection_status'

module Fliclib
  module Protocol
    module Events
      class CreateConnectionChannelResponse < Event
        endian :little

        uint32 :connection_id
        create_connection_channel_error :error
        connection_status :connection_status
      end
    end
  end
end
