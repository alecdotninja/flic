require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'

module Fliclib
  module Protocol
    module Events
      class NoSpaceForNewConnection < Event
        endian :little

        uint8 :maximum_concurrently_connected_buttons
      end
    end
  end
end
