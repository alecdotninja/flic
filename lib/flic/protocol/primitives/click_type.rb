require 'flic/protocol/primitives'
require 'flic/protocol/primitives/enum'

module Flic
  module Protocol
    module Primitives
      # The type of click registered by a button
      # [:button_down] The button was pressed.
      # [:button_up] The button was released.
      # [:button_click] The button was clicked, and was held for at most 1 second between press and release.
      # [:button_single_click] The button was clicked once.
      # [:button_double_click] The button was clicked twice. The time between the first and second press must be at most 0.5 seconds.
      # [:button_hold] The button was held for at least 1 second.
      class ClickType < Enum
        option :button_down
        option :button_up
        option :button_click
        option :button_single_click
        option :button_double_click
        option :button_hold
      end
    end
  end
end