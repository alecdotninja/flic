require 'fliclib'

module Fliclib
  module Events
    autoload :AdvertisementPacket, 'fliclib/events/advertisement_packet'
    autoload :BluetoothControllerStateChange, 'fliclib/events/bluetooth_controller_state_change'
    autoload :ButtonClickOrHold, 'fliclib/events/button_click_or_hold'
    autoload :ButtonSingleOrDoubleClick, 'fliclib/events/button_single_or_double_click'
    autoload :ButtonSingleOrDoubleClickOrHold, 'fliclib/events/button_single_or_double_click_or_hold'
    autoload :ButtonUpOrDown, 'fliclib/events/button_up_or_down'
    autoload :ConnectionChannelRemoved, 'fliclib/events/connection_channel_removed'
    autoload :ConnectionStatusChanged, 'fliclib/events/connection_status_changed'
    autoload :CreateConnectionChannelResponse, 'fliclib/events/create_connection_channel_response'
    autoload :Event, 'fliclib/events/event'
    autoload :GetButtonUuidResponse, 'fliclib/events/get_button_uuid_response'
    autoload :GetInfoResponse, 'fliclib/events/get_info_response'
    autoload :GotSpaceForNewConnection, 'fliclib/events/got_space_for_new_connection'
    autoload :NewVerifiedButton, 'fliclib/events/new_verified_button'
    autoload :NoSpaceForNewConnection, 'fliclib/events/no_space_for_new_connection'
    autoload :PingResponse, 'fliclib/events/ping_response'
    autoload :ScanWizardButtonConnected, 'fliclib/events/scan_wizard_button_connected'
    autoload :ScanWizardCompleted, 'fliclib/events/scan_wizard_completed'
    autoload :ScanWizardFoundPrivateButton, 'fliclib/events/scan_wizard_found_private_button'
    autoload :ScanWizardFoundPublicButton, 'fliclib/events/scan_wizard_found_public_button'

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