require 'fliclib/events'
require 'fliclib/events/event'
require 'fliclib/primitives/bluetooth_address'

module Fliclib
  module Events
    class NewVerifiedButton < Event
      endian :little

      bluetooth_address :bluetooth_address
    end
  end
end
