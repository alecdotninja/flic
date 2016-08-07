require 'fliclib/commands'
require 'fliclib/commands/command'

module Fliclib
  module Commands
    class RemoveScanner < Command
      endian :little

      uint32 :scan_id
    end
  end
end
