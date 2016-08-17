require 'flic/protocol/events'
require 'flic/protocol/events/event'
require 'flic/protocol/primitives/click_type'
require 'flic/protocol/primitives/boolean'

module Flic
  module Protocol
    module Events
      class ButtonSingleOrDoubleClickOrHold < Event
        uint32le :connection_channel_id
        click_type :click_type
        boolean :was_queued
        uint32le :time_difference
      end
    end
  end
end
