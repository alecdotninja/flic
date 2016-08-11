require 'flic/protocol/events'
require 'flic/protocol/events/event'

module Flic
  module Protocol
    module Events
      class PingResponse < Event
        endian :little

        uint32 :ping_id
      end
    end
  end
end
