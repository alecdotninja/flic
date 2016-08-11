require 'fliclib/protocol'

module Fliclib
  module Protocol
    module Events
      autoload :AdvertisementPacket, 'fliclib/protocol/events/advertisement_packet'
      autoload :BluetoothControllerStateChange, 'fliclib/protocol/events/bluetooth_controller_state_change'
      autoload :ButtonClickOrHold, 'fliclib/protocol/events/button_click_or_hold'
      autoload :ButtonSingleOrDoubleClick, 'fliclib/protocol/events/button_single_or_double_click'
      autoload :ButtonSingleOrDoubleClickOrHold, 'fliclib/protocol/events/button_single_or_double_click_or_hold'
      autoload :ButtonUpOrDown, 'fliclib/protocol/events/button_up_or_down'
      autoload :ConnectionChannelRemoved, 'fliclib/protocol/events/connection_channel_removed'
      autoload :ConnectionStatusChanged, 'fliclib/protocol/events/connection_status_changed'
      autoload :CreateConnectionChannelResponse, 'fliclib/protocol/events/create_connection_channel_response'
      autoload :Event, 'fliclib/protocol/events/event'
      autoload :GetButtonUuidResponse, 'fliclib/protocol/events/get_button_uuid_response'
      autoload :GetInfoResponse, 'fliclib/protocol/events/get_info_response'
      autoload :GotSpaceForNewConnection, 'fliclib/protocol/events/got_space_for_new_connection'
      autoload :NewVerifiedButton, 'fliclib/protocol/events/new_verified_button'
      autoload :NoSpaceForNewConnection, 'fliclib/protocol/events/no_space_for_new_connection'
      autoload :PingResponse, 'fliclib/protocol/events/ping_response'
      autoload :ScanWizardButtonConnected, 'fliclib/protocol/events/scan_wizard_button_connected'
      autoload :ScanWizardCompleted, 'fliclib/protocol/events/scan_wizard_completed'
      autoload :ScanWizardFoundPrivateButton, 'fliclib/protocol/events/scan_wizard_found_private_button'
      autoload :ScanWizardFoundPublicButton, 'fliclib/protocol/events/scan_wizard_found_public_button'
  
      EVENT_CLASS_OPCODE = {
          Events::AdvertisementPacket                     => 0x00,
          Events::CreateConnectionChannelResponse         => 0x01,
          Events::ConnectionStatusChanged                 => 0x02,
          Events::ConnectionChannelRemoved                => 0x03,
          Events::ButtonUpOrDown                          => 0x04,
          Events::ButtonClickOrHold                       => 0x05,
          Events::ButtonSingleOrDoubleClick               => 0x06,
          Events::ButtonSingleOrDoubleClickOrHold         => 0x07,
          Events::NewVerifiedButton                       => 0x08,
          Events::GetInfoResponse                         => 0x09,
          Events::NoSpaceForNewConnection                 => 0x0A,
          Events::GotSpaceForNewConnection                => 0x0B,
          Events::BluetoothControllerStateChange          => 0x0C,
          Events::PingResponse                            => 0x0D,
          Events::GetButtonUuidResponse                   => 0x0E,
          Events::ScanWizardFoundPrivateButton            => 0x0F,
          Events::ScanWizardFoundPublicButton             => 0x10,
          Events::ScanWizardButtonConnected               => 0x11,
          Events::ScanWizardCompleted                     => 0x12
      }.freeze
  
      OPCODE_EVENT_CLASS = EVENT_CLASS_OPCODE.invert.freeze
  
      def self.event_class_for_opcode(opcode)
        OPCODE_EVENT_CLASS[opcode]
      end
  
      def self.opcode_for_event_class(event_class)
        EVENT_CLASS_OPCODE[event_class]
      end
    end
  end
end