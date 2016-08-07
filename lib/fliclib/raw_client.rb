require 'fliclib'
require 'fliclib/commands'
require 'fliclib/events'

require 'socket'

module Fliclib
  class RawClient
    class << self
      def open(*args)
        client = new(*args)

        begin
          yield client
        ensure
          client.close
        end
      end
    end

    def initialize(*args)
      @socket = TCPSocket.new(*args)
      @semaphore = Mutex.new

      yield self if block_given?
    end

    def close
      @socket.close
    end

    def closed?
      @socket.closed?
    end

    def send_command(command)
      send_packet command.to_binary_s
    end

    def listen
      loop do
        break if closed?

        yield recv_event
      end
    end

    def recv_event
      blocking { recv_event_nonblock }
    end

    def recv_event_nonblock
      payload = recv_packet_nonblock
      event = Events::Event.read(payload)
      event_class = Events.event_class_for_opcode(event.opcode)
      event_class.read(payload)
    end

    private

    def send_packet(payload)
      @semaphore.synchronize do
        packet_header = PacketHeader.new(byte_length: payload.bytesize)
        @socket.write(packet_header.to_binary_s)
        @socket.write(payload)
      end
    end

    def recv_packet
      blocking { recv_packet_nonblock }
    end

    def recv_packet_nonblock
      payload = nil

      @semaphore.synchronize do
        unless @packet_byte_length
          @packet_header_bytes ||= String.new

          packet_header = PacketHeader.new

          while @packet_header_bytes.bytesize < packet_header.num_bytes
            @packet_header_bytes << @socket.read_nonblock(packet_header.num_bytes - @packet_header_bytes.bytesize)
          end

          packet_header.read(@packet_header_bytes)
          @packet_header_bytes = nil
          @packet_byte_length = packet_header.byte_length
        end

        @payload ||= String.new

        while @payload.bytesize < @packet_byte_length
          @payload << @socket.read_nonblock(@packet_byte_length - @payload.bytesize)
        end

        payload = @payload

        @packet_byte_length = nil
        @payload = nil
      end

      payload
    end

    def blocking
      yield
    rescue IO::WaitReadable
      IO.select([@socket])

      retry
    end
  end
end