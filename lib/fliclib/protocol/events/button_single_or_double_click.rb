require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'
require 'fliclib/protocol/primitives/click_type'
require 'fliclib/protocol/primitives/boolean'

module Fliclib
  module Protocol
    module Events
      class ButtonSingleOrDoubleClick < Event
        endian :little

        uint32 :connection_id
        click_type :click_type
        boolean :was_queued
        uint32 :time_difference
      end
    end
  end
end
