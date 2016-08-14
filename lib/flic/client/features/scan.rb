require 'flic/client/features'

require 'thread'

module Flic
  class Client
    module Features
      module Scan
        def initialize(*)
          @scan_id_scanner_semaphore = Mutex.new
          @scan_id_scanner = {}

          super
        end

        def scanners
          @scan_id_scanner_semaphore.synchronize { @scan_id_scanner.values }
        end

        def add_scanner(scanner)
          scan_id = _add_scanner(scanner)

          send_command Protocol::Commands::CreateScanner.new(scan_id: scan_id) if scan_id
        end

        def remove_scanner(scanner)
          scan_id = _remove_scanner(scanner)

          send_command Protocol::Commands::RemoveScanner.new(scan_id: scan_id) if scan_id
        end

        def shutdown(*)
          scanners.each do |scanner|
            _remove_scanner(scanner)
          end

          super
        end

        private

        def handle_event(event)
          case event
            when Protocol::Events::AdvertisementPacket
              scanner = find_scanner_for_scan_id(scanner)

              if scanner
                scanner.advertisement_received(
                    event.bluetooth_address,
                    event.name,
                    event.rssi,
                    event.is_private,
                    event.is_already_verified
                )
              end
            else
              super
          end
        end

        def _add_scanner(scanner)
          scan_id = nil

          @scan_id_scanner_semaphore.synchronize do
            unless @scan_id_scanner.values.include?(scanner)
              loop do
                scan_id = rand(2**32)

                break unless @scan_id_scanner.has_key?(scan_id)
              end

              @scan_id_scanner[scan_id] = scanner
            end
          end

          scanner.added self if scan_id # we have to do this here because the server does not callback

          scan_id
        end

        def _remove_scanner(scanner)
          scan_id = nil

          @scan_id_scanner_semaphore.synchronize do
            @scan_id_scanner.each do |_scan_id, _scanner|
              if scanner == _scanner
                scan_id = _scan_id
                break
              end
            end

            @scan_id_scanner.delete scan_id if scan_id
          end

          scanner.removed self if scan_id # we have to do this here because the server does not callback

          scan_id
        end

        def find_scanner_for_scan_id(needle)
          @scan_id_scanner_semaphore.synchronize do
            @scan_id_scanner.each do |scan_id, scanner|
              return scanner if scan_id == needle
            end
          end

          nil
        end
      end
    end
  end
end