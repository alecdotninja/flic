require 'flic/protocol/events'
require 'flic/protocol/events/event'
require 'flic/protocol/primitives/bluetooth_address'

module Flic
  module Protocol
    module Events
      class NewVerifiedButton < Event
        bluetooth_address :bluetooth_address
      end
    end
  end
end
