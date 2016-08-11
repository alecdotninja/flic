require 'fliclib/protocol'

module Fliclib
  module Protocol
    module Commands
      autoload :CancelScanWizard, 'fliclib/protocol/commands/cancel_scan_wizard'
      autoload :ChangeModeParameters, 'fliclib/protocol/commands/change_mode_parameters'
      autoload :Command, 'fliclib/protocol/commands/command'
      autoload :CreateConnectionChannel, 'fliclib/protocol/commands/create_connection_channel'
      autoload :CreateScanWizard, 'fliclib/protocol/commands/create_scan_wizard'
      autoload :CreateScanner, 'fliclib/protocol/commands/create_scanner'
      autoload :ForceDisconnect, 'fliclib/protocol/commands/force_disconnect'
      autoload :GetButtonUuid, 'fliclib/protocol/commands/get_button_uuid'
      autoload :GetInfo, 'fliclib/protocol/commands/get_info'
      autoload :Ping, 'fliclib/protocol/commands/ping'
      autoload :RemoveConnectionChannel, 'fliclib/protocol/commands/remove_connection_channel'
      autoload :RemoveScanner, 'fliclib/protocol/commands/remove_scanner'

      COMMAND_CLASS_OPCODE = {
          Commands::GetInfo                   => 0x00,
          Commands::CreateScanner             => 0x01,
          Commands::RemoveScanner             => 0x02,
          Commands::CreateConnectionChannel   => 0x03,
          Commands::RemoveConnectionChannel   => 0x04,
          Commands::ForceDisconnect           => 0x05,
          Commands::ChangeModeParameters      => 0x06,
          Commands::Ping                      => 0x07,
          Commands::GetButtonUuid             => 0x08,
          Commands::CreateScanWizard          => 0x09,
          Commands::CancelScanWizard          => 0x0A
      }.freeze

      OPCODE_COMMAND_CLASS = COMMAND_CLASS_OPCODE.invert.freeze

      def self.command_class_for_opcode(opcode)
        OPCODE_COMMAND_CLASS[opcode]
      end

      def self.opcode_for_command_class(command_class)
        COMMAND_CLASS_OPCODE[command_class]
      end
    end
  end
end