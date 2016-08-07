require 'fliclib/events'
require 'fliclib/events/event'
require 'fliclib/primitives/removed_reason'

module Fliclib
  module Events
    class ConnectionChannelRemoved < Event
      endian :little

      uint32 :connection_id
      removed_reason :removed_reason
    end
  end
end
