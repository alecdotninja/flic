require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'
require 'fliclib/protocol/primitives/removed_reason'

module Fliclib
  module Protocol
    module Events
      class ConnectionChannelRemoved < Event
        endian :little

        uint32 :connection_id
        removed_reason :removed_reason
      end
    end
  end
end
