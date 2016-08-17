require 'flic'

module Flic
  # This module contains an implementation of the Flic binary protocol. Of particular external interest is
  # `Flic::Protocol::Connection` which provides a wrapper for the binary protocol around a socket instance.
  module Protocol
    extend self

    class Error < StandardError; end

    autoload :Commands, 'flic/protocol/commands'
    autoload :Connection, 'flic/protocol/connection'
    autoload :Events, 'flic/protocol/events'
    autoload :PacketHeader, 'flic/protocol/packet_header'
    autoload :Primitives, 'flic/protocol/primitives'

    # Serializes an instance of a protocol command class to a binary string
    # @param command [Flic::Protocol::Commands::Command]
    # @return [String] binary string
    def serialize_command(command)
      case command
        when Commands::Command
          command.to_binary_s
        else
          raise NotImplementedError
      end
    rescue
      raise Error, "Cannot serialize command `#{command.inspect}`"
    end

    # Deserializes an instance of a protocol command class from a binary string
    # @param serialized_command [String] binary string
    # @return [Flic::Protocol::Commands::Command]
    def parse_command(serialized_command)
      command = Commands::Command.read(serialized_command)
      opcode = command.opcode
      command_class = Commands::Command.command_class_for_opcode(opcode)

      if command_class
        command_class.read(serialized_command)
      else
        raise NotImplementedError, "Unknown command opcode #{opcode}"
      end
    rescue
      raise Error, "Cannot parse event `#{serialized_command.inspect}`"
    end

    # Serializes an instance of a protocol event class to a binary string
    # @param event [Flic::Protocol::Events::Event]
    # @return [String] binary string
    def serialize_event(event)
      case event
        when Commands::Event
          event.to_binary_s
        else
          raise NotImplementedError
      end
    rescue
      raise Error, "Cannot serialize event `#{event.inspect}`"
    end

    # Deserializes an instance of a protocol event class from a binary string
    # @param serialized_event [String] binary string
    # @return [Flic::Protocol::Events::Event]
    def parse_event(serialized_event)
      event = Events::Event.read(serialized_event)
      opcode = event.opcode
      event_class = Events.event_class_for_opcode(opcode)

      if event_class
        event_class.read(serialized_event)
      else
        raise NotImplementedError, "Unknown event opcode #{opcode}"
      end
    rescue
      raise Error, "Cannot parse event `#{serialized_event.inspect}`"
    end
  end
end