require 'fliclib/protocol/events'
require 'fliclib/protocol/events/event'
require 'fliclib/protocol/primitives/bluetooth_address'
require 'fliclib/protocol/primitives/uuid'

module Fliclib
  module Protocol
    module Events
      class GetButtonUuidResponse < Event
        endian :little

        bluetooth_address :bluetooth_address
        uuid :uuid
      end
    end
  end
end
