require 'flic/protocol'

module Flic
  module Protocol
    class Connection
      class UnderlyingSocketClosedError < Error; end
      class UnexpectedNilReturnValueFromRead < Error; end

      attr_reader :socket

      def initialize(socket)
        @socket = socket
        @read_semaphore = Mutex.new
        @write_semaphore = Mutex.new
      end

      def send_command(command)
        send_packet Protocol.serialize_command(command)
      end

      def recv_command
        Protocol.parse_command(recv_packet)
      end

      def send_event(event)
        send_packet Protocol.serialize_event(event)
      end

      def recv_event
        Protocol.parse_event(recv_packet)
      end

      private

      def send_packet(payload)
        @write_semaphore.synchronize do
          packet_header = Protocol::PacketHeader.new(byte_length: payload.bytesize)
          @socket.write(packet_header.to_binary_s)
          @socket.write(payload)
        end
      rescue RuntimeError, IOError
        if @socket.closed?
          raise UnderlyingSocketClosedError
        else
          raise
        end
      end

      def recv_packet
        @read_semaphore.synchronize do
          packet_header = Protocol::PacketHeader.new
          packet_header_bytes = @socket.read packet_header.num_bytes

          raise UnexpectedNilReturnValueFromRead unless packet_header_bytes

          packet_header.read(packet_header_bytes)

          @socket.read(packet_header.byte_length)
        end
      rescue UnexpectedNilReturnValueFromRead
        @socket.close
        retry
      rescue RuntimeError, IOError
        if @socket.closed?
          raise UnderlyingSocketClosedError
        else
          raise
        end
      end
    end
  end
end