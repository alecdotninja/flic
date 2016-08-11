require 'fliclib'
require 'fliclib/client'
require 'fliclib/protocol'

require 'socket'

module Fliclib
  class Client
    class Connection
      class Error < StandardError; end
      class ConnectionClosedError < Error; end

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

      attr_reader :hostname, :port

      def initialize(hostname, port = 5551, *additional_socket_args)
        @hostname, @port = hostname, port
        @socket = TCPSocket.new(hostname, port, *additional_socket_args)
        @read_semaphore = Mutex.new
        @write_semaphore = Mutex.new
      end

      def send_command(command)
        send_packet Protocol.serialize_command(command)
      end

      def recv_event
        Protocol.parse_event(recv_packet)
      end

      def listen
        loop { yield recv_event }
      end

      def closed?
        @socket.closed?
      end

      def close
        @socket.close
      end

      private

      def send_packet(payload)
        @write_semaphore.synchronize do
          packet_header = Protocol::PacketHeader.new(byte_length: payload.bytesize)
          @socket.write(packet_header.to_binary_s)
          @socket.write(payload)
        end
      rescue IOError
        if closed?
          raise ConnectionClosedError
        else
          raise
        end
      end

      def recv_packet
        @read_semaphore.synchronize do
          packet_header = Protocol::PacketHeader.new
          packet_header_bytes = @socket.read packet_header.num_bytes
          packet_header.read(packet_header_bytes)

          @socket.read(packet_header.byte_length)
        end
      rescue IOError
        if closed?
          raise ConnectionClosedError
        else
          raise
        end
      end
    end
  end
end