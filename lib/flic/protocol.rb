require 'flic'

module Flic
  module Protocol
    class Error < StandardError; end

    autoload :Commands, 'flic/protocol/commands'
    autoload :Events, 'flic/protocol/events'
    autoload :PacketHeader, 'flic/protocol/packet_header'
    autoload :Primitives, 'flic/protocol/primitives'

    def self.serialize_command(command)
      case command
        when Commands::Command
          command.to_binary_s
        else
          raise NotImplementedError
      end
    rescue
      raise Error, "Cannot serialize command `#{command.inspect}`"
    end

    def self.parse_command(serialized_command)
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

    def self.serialize_event(event)
      case event
        when Commands::Event
          event.to_binary_s
        else
          raise NotImplementedError
      end
    rescue
      raise Error, "Cannot serialize event `#{event.inspect}`"
    end

    def self.parse_event(serialized_event)
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