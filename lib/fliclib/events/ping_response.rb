require 'fliclib/events'
require 'fliclib/events/event'

module Fliclib
  module Events
    class PingResponse < Event
      endian :little

      uint32 :ping_id
    end
  end
end
