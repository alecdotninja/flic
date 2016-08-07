require 'fliclib/enum'

require 'bindata'

module Fliclib
  module Primitives
    class CreateConnectionChannelError < BinData::Primitive
      include Enum

      option :no_error                              # There were space in the bluetooth controller's white list to accept a physical pending connection for this button
      option :maximum_pending_connections_reached   # There were no space left in the bluetooth controller to allow a new pending connection
    end
  end
end