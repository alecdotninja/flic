require 'fliclib/events'
require 'fliclib/events/event'
require 'fliclib/primitives/bluetooth_address'
require 'fliclib/primitives/uuid'

module Fliclib
  module Events
    class GetButtonUuidResponse < Event
      endian :little

      bluetooth_address :bluetooth_address
      uuid :uuid
    end
  end
end
