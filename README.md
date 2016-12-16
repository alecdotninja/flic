# Flic
Flic is a lightweight but thread-safe Ruby implementation of the [Fliclib](https://github.com/50ButtonsEach/fliclib-linux-hci/blob/master/ProtocolDocumentation.md). It interfaces with [flicd](https://github.com/50ButtonsEach/fliclib-linux-hci), and allows [Flic buttons](https://flic.io/) to be used as an input for Ruby applications.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'flic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flic

## Simple Usage
The easiest way to get up an running is to use `Flic::SimpleClient`. It is a thin wrapper around `Flic::Client` that provides a simplified, synchronous API for the most intuative uses of a Flic button.

### Establishing a connection to `flicd`
By default, `flicd` binds to `localhost` on port `5551`. These are also the defaults for `Filc::SimpleClient`. This means that if you are running `flicd` on your local machine, establishing a connection is as easy as creating a new instance of `Flic::SimpleClient`. For other configurations, you can initialize `Flic::SimpleCient` with host and port. For example, `Flic::SimpleClient.new('192.168.1.200', 5553)` will open a connection to `flicd` on `192.168.1.200` listening on port `5553`.

### Getting a list of buttons
To get a list of verified buttons (buttons associated and ready to be used with a given `flicd`), call `Flic::SimpleClient#buttons`. This will return a list of button's bluetooth addresses.

### Connecting a new button
A button must be in public mode before it can be added. To put a button in public mode, press and hold it for at least 7 seconds. `Flic::SimpleClient#connect_button` will return the bluetooh address of the button that was added or `nil` if no button was added.

### Disconnecting a button
Similarly, a button may be disconnected by passing `Flic::SimpleClient#disconnect_button` a button's bluetooth address.

### Listening for button events
`Flic::SimpleClient#listen` accepts a latency mode (`:low`, `:normal`, or `:high`) as it's first argument and button bluetooth addresses as its other arguments. For each event that occurs to those buttons, it yields the bluetooth address of the button responsible for a given event, the type of click involved in the event (`:button_down`, `:button_up`, `:button_single_click`, `:button_double_click`, or `:button_hold`), the time in seconds since the event occured, and whether the event was queued. **It will block until the connection is closed or the block raises some other exception.**

### Closing the connection to `flicd`
To gracefully cleanup all connection channels and close the socket connection, call `Flic::SimpleClient#shutdown`. Once a `Flic::SimpleClient` has been shutdown it will close the underlying socket and cannot be used anymore.

### Example
This is the script that I wrote to allow some of my Flic buttons to control Wink-enabled smart devices in home.
```ruby

#!/usr/bin/env ruby

require 'bundler/setup'
require 'flic'
require 'httparty'

# Obtained from https://winkbearertoken.appspot.com/
WINK_ACCESS_TOKEN	= 'YOUR ACCESS TOKEN HERE'

# These bluetooth addresses were obtained from SimpleClient#connect_button
LIVING_ROOM_BUTTON 	= 'XX:XX:XX:XX:XX:XX'
BEDROOM_BUTTON 		= 'XX:XX:XX:XX:XX:XX'
NIGHTSTAND_BUTTON 	= 'XX:XX:XX:XX:XX:XX'

begin
    puts "[*] Opening a connection to flicd..."
    client = Flic::SimpleClient.new

    puts "[*] Entering main loop"
    client.listen(:low, LIVING_ROOM_BUTTON, BEDROOM_BUTTON, NIGHTSTAND_BUTTON) do |button, event, latency|
        if latency > 10
            puts "[*] [#{button}] Ignoring #{event} because the latency is #{latency} seconds"
        else
            puts "[*] [#{button}] Handling #{event}"

            case button
            when LIVING_ROOM_BUTTON
                case event
                when :button_single_click
                    puts HTTParty.post('https://api.wink.com/scenes/SCENE_ID/activate', headers: { Authorization: "Bearer #{WINK_ACCESS_TOKEN}" }).inspect
                when :button_double_click
                    puts HTTParty.post('https://api.wink.com/scenes/SCENE_ID/activate', headers: { Authorization: "Bearer #{WINK_ACCESS_TOKEN}" }).inspect
                when :button_hold
                    puts HTTParty.post('https://api.wink.com/scenes/SCENE_ID/activate', headers: { Authorization: "Bearer #{WINK_ACCESS_TOKEN}" }).inspect
                end

            when BEDROOM_BUTTON
                case event
                when :button_single_click
                    puts HTTParty.post('https://api.wink.com/scenes/SCENE_ID/activate', headers: { Authorization: "Bearer #{WINK_ACCESS_TOKEN}" }).inspect
                when :button_double_click
                    puts HTTParty.post('https://api.wink.com/scenes/SCENE_ID/activate', headers: { Authorization: "Bearer #{WINK_ACCESS_TOKEN}" }).inspect
                when :button_hold
                    puts HTTParty.post('https://api.wink.com/scenes/SCENE_ID/activate', headers: { Authorization: "Bearer #{WINK_ACCESS_TOKEN}" }).inspect
                end

            when NIGHTSTAND_BUTTON
                case event
                when :button_single_click
                    puts HTTParty.post('https://api.wink.com/scenes/SCENE_ID/activate', headers: { Authorization: "Bearer #{WINK_ACCESS_TOKEN}" }).inspect
                when :button_double_click
                    puts HTTParty.post('https://api.wink.com/scenes/SCENE_ID/activate', headers: { Authorization: "Bearer #{WINK_ACCESS_TOKEN}" }).inspect
                when :button_hold
                    puts HTTParty.post('https://api.wink.com/scenes/SCENE_ID/activate', headers: { Authorization: "Bearer #{WINK_ACCESS_TOKEN}" }).inspect
                end
            end
        end
    end
rescue StandardError => error
    puts "[!] Whoops! #{error.inspect} occured. Wait for a second and restart everything."
    sleep 1

    retry
rescue Interrupt
    puts "[*] Shutting down gracefully because of an interrupt"

    client.shutdown
end

puts "[*] Goodbye cruel world!"

```

## Advanced Usage
The interface of `Flic::Client` closely mirrors [the official Java implimentation](https://github.com/50ButtonsEach/fliclib-linux-hci/tree/master/clientlib/java). Unlike `Flic::SimpleClient`, none of it's methods are blocking except `Flic::Client#handle_next_event` which blocks until the next event is recevied and dispatches it to the approprate handlers and `Flic::Client#enter_main_loop` which blocks until the client is shutdown and dispatches events as they are received. Ideally, `Flic::Client#enter_main_loop` should be run in a dedicated networking / event dispatch thread.


## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/anarchocurious/flic.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
