require 'flic/protocol/primitives'
require 'flic/protocol/primitives/enum'

module Flic
  module Protocol
    module Primitives
      class ClickType < Enum
        option :button_down           # The button was pressed.
        option :button_up             # The button was released.
        option :button_click          # The button was clicked, and was held for at most 1 second between press and release.
        option :button_single_click   # The button was clicked once.
        option :button_double_click   # The button was clicked twice. The time between the first and second press must be at most 0.5 seconds.
        option :button_hold           # The button was held for at least 1 second.
      end
    end
  end
end