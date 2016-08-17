require 'flic/protocol/events'
require 'flic/protocol/events/event'
require 'flic/protocol/primitives/bluetooth_address'
require 'flic/protocol/primitives/uuid'

module Flic
  module Protocol
    module Events
      class GetButtonUuidResponse < Event
        bluetooth_address :bluetooth_address
        uuid :uuid
      end
    end
  end
end
