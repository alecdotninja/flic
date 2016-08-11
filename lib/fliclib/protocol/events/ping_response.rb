require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'

module Fliclib
  module Protocol
    module Events
      class PingResponse < Event
        endian :little

        uint32 :ping_id
      end
    end
  end
end
