require 'fliclib/enum'

require 'bindata'

module Fliclib
  module Primitives
    class ConnectionStatus < BinData::Primitive
      include Enum

      option :disconnected  # Not currently an established connection, but will connect as soon as the button is pressed and it is in range as long as the connection channel hasn't been removed (and unless maximum number of concurrent connections has been reached or the bluetooth controller has been detached).
      option :connected     # The physical bluetooth connection has just been established and the server and the button are currently verifying each other. As soon as this is done, it will switch to the ready status.
      option :ready         # The verification is done and button events may now arrive.
    end
  end
end