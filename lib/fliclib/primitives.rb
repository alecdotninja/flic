require 'fliclib'

module Fliclib
  module Primitives
    autoload :BluetoothAddress, 'fliclib/primitives/bluetooth_address'
    autoload :BluetoothAddressType, 'fliclib/primitives/bluetooth_address_type'
    autoload :BluetoothControllerState, 'fliclib/primitives/bluetooth_controller_state'
    autoload :Boolean, 'fliclib/primitives/boolean'
    autoload :ClickType, 'fliclib/primitives/click_type'
    autoload :ConnectionStatus, 'fliclib/primitives/connection_status'
    autoload :CreateConnectionChannelError, 'fliclib/primitives/create_connection_channel_error'
    autoload :DeviceName, 'fliclib/primitives/device_name'
    autoload :DisconnectReason, 'fliclib/primitives/disconnect_reason'
    autoload :LatencyMode, 'fliclib/primitives/latency_mode'
    autoload :RemovedReason, 'fliclib/primitives/removed_reason'
    autoload :ScanWizardResult, 'fliclib/primitives/scan_wizard_result'
    autoload :Uuid, 'fliclib/primitives/uuid'
  end
end