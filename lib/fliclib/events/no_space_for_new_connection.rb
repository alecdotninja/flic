require 'fliclib/events'
require 'fliclib/events/event'

module Fliclib
  module Events
    class NoSpaceForNewConnection < Event
      endian :little

      uint8 :maximum_concurrently_connected_buttons
    end
  end
end
