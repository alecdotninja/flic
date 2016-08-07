require 'fliclib/commands'
require 'fliclib/commands/command'

module Fliclib
  module Commands
    class Ping < Command
      endian :little

      uint32 :ping_id
    end
  end
end
