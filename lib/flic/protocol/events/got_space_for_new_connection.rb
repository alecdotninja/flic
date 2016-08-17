require 'flic/protocol/events'
require 'flic/protocol/events/event'

module Flic
  module Protocol
    module Events
      class GotSpaceForNewConnection < Event
        uint8le :maximum_concurrently_connected_buttons
      end
    end
  end
end
