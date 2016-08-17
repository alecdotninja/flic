require 'flic/protocol'

module Flic
  module Protocol
    # A namespace module for all of the primitive classes
    module Primitives
      autoload :BluetoothAddress, 'flic/protocol/primitives/bluetooth_address'
      autoload :BluetoothAddressType, 'flic/protocol/primitives/bluetooth_address_type'
      autoload :BluetoothControllerState, 'flic/protocol/primitives/bluetooth_controller_state'
      autoload :Boolean, 'flic/protocol/primitives/boolean'
      autoload :ClickType, 'flic/protocol/primitives/click_type'
      autoload :ConnectionStatus, 'flic/protocol/primitives/connection_status'
      autoload :CreateConnectionChannelError, 'flic/protocol/primitives/create_connection_channel_error'
      autoload :DeviceName, 'flic/protocol/primitives/device_name'
      autoload :DisconnectReason, 'flic/protocol/primitives/disconnect_reason'
      autoload :DisconnectTime, 'flic/protocol/primitives/disconnect_time'
      autoload :Enum, 'flic/protocol/primitives/enum'
      autoload :LatencyMode, 'flic/protocol/primitives/latency_mode'
      autoload :RemovedReason, 'flic/protocol/primitives/removed_reason'
      autoload :ScanWizardResult, 'flic/protocol/primitives/scan_wizard_result'
      autoload :Uuid, 'flic/protocol/primitives/uuid'
    end
  end
end