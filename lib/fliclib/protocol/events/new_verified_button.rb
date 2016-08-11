require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'
require 'fliclib/protocol/primitives/bluetooth_address'

module Fliclib
  module Protocol
    module Events
      class NewVerifiedButton < Event
        endian :little

        bluetooth_address :bluetooth_address
      end
    end
  end
end
