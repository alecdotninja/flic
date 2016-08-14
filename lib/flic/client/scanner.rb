require 'flic/client'

module Flic
  class Client
    class Scanner
      extend Callbacks

      define_callbacks :added, :removed,
                       :advertisement_received
    end
  end
end
