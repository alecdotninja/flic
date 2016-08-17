require 'flic/protocol'

module Flic
  module Protocol
    # A namespace module for all of the event classes
    module Events
      autoload :AdvertisementPacket, 'flic/protocol/events/advertisement_packet'
      autoload :BluetoothControllerStateChange, 'flic/protocol/events/bluetooth_controller_state_change'
      autoload :ButtonClickOrHold, 'flic/protocol/events/button_click_or_hold'
      autoload :ButtonSingleOrDoubleClick, 'flic/protocol/events/button_single_or_double_click'
      autoload :ButtonSingleOrDoubleClickOrHold, 'flic/protocol/events/button_single_or_double_click_or_hold'
      autoload :ButtonUpOrDown, 'flic/protocol/events/button_up_or_down'
      autoload :ConnectionChannelRemoved, 'flic/protocol/events/connection_channel_removed'
      autoload :ConnectionStatusChanged, 'flic/protocol/events/connection_status_changed'
      autoload :CreateConnectionChannelResponse, 'flic/protocol/events/create_connection_channel_response'
      autoload :Event, 'flic/protocol/events/event'
      autoload :GetButtonUuidResponse, 'flic/protocol/events/get_button_uuid_response'
      autoload :GetInfoResponse, 'flic/protocol/events/get_info_response'
      autoload :GotSpaceForNewConnection, 'flic/protocol/events/got_space_for_new_connection'
      autoload :NewVerifiedButton, 'flic/protocol/events/new_verified_button'
      autoload :NoSpaceForNewConnection, 'flic/protocol/events/no_space_for_new_connection'
      autoload :PingResponse, 'flic/protocol/events/ping_response'
      autoload :ScanWizardButtonConnected, 'flic/protocol/events/scan_wizard_button_connected'
      autoload :ScanWizardCompleted, 'flic/protocol/events/scan_wizard_completed'
      autoload :ScanWizardFoundPrivateButton, 'flic/protocol/events/scan_wizard_found_private_button'
      autoload :ScanWizardFoundPublicButton, 'flic/protocol/events/scan_wizard_found_public_button'
  
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

      # Finds the event class for a given opcode
      # @param opcode [Integer]
      # @return [Class]
      def self.event_class_for_opcode(opcode)
        OPCODE_EVENT_CLASS[opcode]
      end

      # Finds the opcode for a given event class
      # @param event_class [Class]
      # @return [Integer]
      def self.opcode_for_event_class(event_class)
        EVENT_CLASS_OPCODE[event_class]
      end
    end
  end
end