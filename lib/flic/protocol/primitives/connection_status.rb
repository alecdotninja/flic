require 'flic/protocol/primitives'
require 'flic/protocol/primitives/enum'

module Flic
  module Protocol
    module Primitives
      # [:disconnected] Not currently an established connection, but will connect as soon as the button is pressed and it is in range as long as the connection channel hasn't been removed (and unless maximum number of concurrent connections has been reached or the bluetooth controller has been detached).
      # [:connected] The physical bluetooth connection has just been established and the server and the button are currently verifying each other. As soon as this is done, it will switch to the ready status.
      # [:ready] The verification is done and button events may now arrive.
    class ConnectionStatus < Enum
        option :disconnected
        option :connected
        option :ready
      end
    end
  end
end