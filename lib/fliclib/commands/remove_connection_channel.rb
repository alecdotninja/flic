require 'fliclib/commands'
require 'fliclib/commands/command'

module Fliclib
  module Commands
    class RemoveConnectionChannel < Command
      endian :little

      uint32 :connection_id
    end
  end
end
