require 'fliclib/protocol/primitives'
require 'fliclib/protocol/primitives/enum'

module Fliclib
  module Protocol
    module Primitives
      class CreateConnectionChannelError < Enum
        option :no_error                              # There were space in the bluetooth controller's white list to accept a physical pending connection for this button
        option :maximum_pending_connections_reached   # There were no space left in the bluetooth controller to allow a new pending connection
      end
    end
  end
end