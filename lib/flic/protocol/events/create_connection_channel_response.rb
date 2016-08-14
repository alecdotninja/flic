require 'flic/protocol/events'
require 'flic/protocol/events/event'
require 'flic/protocol/primitives/create_connection_channel_error'
require 'flic/protocol/primitives/connection_status'

module Flic
  module Protocol
    module Events
      class CreateConnectionChannelResponse < Event
        endian :little

        uint32 :connection_channel_id
        create_connection_channel_error :error
        connection_status :connection_status
      end
    end
  end
end
