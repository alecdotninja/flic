require 'fliclib/protocol'

module Fliclib
  module Protocol
    module Primitives
      autoload :BluetoothAddress, 'fliclib/protocol/primitives/bluetooth_address'
      autoload :BluetoothAddressType, 'fliclib/protocol/primitives/bluetooth_address_type'
      autoload :BluetoothControllerState, 'fliclib/protocol/primitives/bluetooth_controller_state'
      autoload :Boolean, 'fliclib/protocol/primitives/boolean'
      autoload :ClickType, 'fliclib/protocol/primitives/click_type'
      autoload :ConnectionStatus, 'fliclib/protocol/primitives/connection_status'
      autoload :CreateConnectionChannelError, 'fliclib/protocol/primitives/create_connection_channel_error'
      autoload :DeviceName, 'fliclib/protocol/primitives/device_name'
      autoload :DisconnectReason, 'fliclib/protocol/primitives/disconnect_reason'
      autoload :Enum, 'fliclib/protocol/primitives/enum'
      autoload :LatencyMode, 'fliclib/protocol/primitives/latency_mode'
      autoload :RemovedReason, 'fliclib/protocol/primitives/removed_reason'
      autoload :ScanWizardResult, 'fliclib/protocol/primitives/scan_wizard_result'
      autoload :Uuid, 'fliclib/protocol/primitives/uuid'
    end
  end
end