require 'fliclib/events'
require 'fliclib/events/event'
require 'fliclib/primitives/create_connection_channel_error'
require 'fliclib/primitives/connection_status'

module Fliclib
  module Events
    class CreateConnectionChannelResponse < Event
      endian :little

      uint32 :connection_id
      create_connection_channel_error :error
      connection_status :connection_status
    end
  end
end
