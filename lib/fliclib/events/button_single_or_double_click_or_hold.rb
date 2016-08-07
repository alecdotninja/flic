require 'fliclib/events'
require 'fliclib/events/event'
require 'fliclib/primitives/click_type'
require 'fliclib/primitives/boolean'

module Fliclib
  module Events
    class ButtonSingleOrDoubleClickOrHold < Event
      endian :little

      uint32 :connection_id
      click_type :click_type
      boolean :was_queued
      uint32 :time_difference
    end
  end
end
