require 'flic/protocol/events'
require 'flic/protocol/events/event'
require 'flic/protocol/primitives/removed_reason'

module Flic
  module Protocol
    module Events
      class ConnectionChannelRemoved < Event
        endian :little

        uint32 :connection_channel_id
        removed_reason :reason
      end
    end
  end
end
