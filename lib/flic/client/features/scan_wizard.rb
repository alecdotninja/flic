require 'flic/client/features'

require 'thread'

module Flic
  class Client
    module Features
      module ScanWizard
        def initialize(*)
          @scan_wizard_id_scan_wizard_semaphore = Mutex.new
          @scan_wizard_id_scan_wizard = {}

          super
        end

        def scan_wizards
          @scan_wizard_id_scan_wizard_semaphore.synchronize { @scan_wizard_id_scan_wizard.values }
        end

        def add_scan_wizard(scan_wizard)
          scan_wizard_id = _add_scan_wizard(scan_wizard)

          if scan_wizard_id
            scan_wizard.added self
            send_command Protocol::Commands::CreateScanWizard.new(scan_wizard_id: scan_wizard_id)
          end
        end

        def remove_scan_wizard(scan_wizard)
          scan_wizard_id = find_scan_wizard_id_for_scan_wizard(scan_wizard)

          send_command Protocol::Commands::CancelScanWizard.new(scan_wizard_id: scan_wizard_id) if scan_wizard_id
        end

        def shutdown(*)
          scan_wizards.each do |scan_wizard|
            _remove_scan_wizard(scan_wizard)
            scan_wizard.removed self, nil, nil, nil
          end

          super
        end

        private

        def handle_event(event)
          case event
            when Protocol::Events::ScanWizardFoundPrivateButton
              scan_wizard = find_scan_wizard_for_scan_wizard_id(event.scan_wizard_id)

              scan_wizard.found_private_button if scan_wizard
            when Protocol::Events::ScanWizardFoundPublicButton
              scan_wizard = find_scan_wizard_for_scan_wizard_id(event.scan_wizard_id)

              scan_wizard.button_bluetooth_address = event.bluetooth_address
              scan_wizard.button_name = event.name
              scan_wizard.found_public_button event.bluetooth_address, event.name
            when Protocol::Events::ScanWizardCompleted
              scan_wizard = find_scan_wizard_for_scan_wizard_id(event.scan_wizard_id)

              if scan_wizard
                _remove_scan_wizard(scan_wizard)

                scan_wizard.result = event.scan_wizard_result
                scan_wizard.removed self, event.scan_wizard_result, scan_wizard.button_bluetooth_address, scan_wizard.button_name
              end
            else
              super
          end
        end

        def _add_scan_wizard(scan_wizard)
          scan_wizard_id = nil

          @scan_wizard_id_scan_wizard_semaphore.synchronize do
            unless @scan_wizard_id_scan_wizard.values.include?(scan_wizard)
              loop do
                scan_wizard_id = rand(2**32)

                break unless @scan_wizard_id_scan_wizard.has_key?(scan_wizard_id)
              end

              @scan_wizard_id_scan_wizard[scan_wizard_id] = scan_wizard
            end
          end

          scan_wizard_id
        end

        def _remove_scan_wizard(scan_wizard)
          scan_wizard_id = nil

          @scan_wizard_id_scan_wizard_semaphore.synchronize do
            if @scan_wizard_id_scan_wizard.values.include?(scan_wizard)
              @scan_wizard_id_scan_wizard.each do |_scan_wizard_id, _scan_wizard|
                if scan_wizard == _scan_wizard
                  scan_wizard_id = _scan_wizard_id
                  break
                end
              end

              @scan_wizard_id_scan_wizard.delete scan_wizard_id if scan_wizard_id
            end
          end

          scan_wizard_id
        end

        def find_scan_wizard_for_scan_wizard_id(needle)
          @scan_wizard_id_scan_wizard_semaphore.synchronize do
            @scan_wizard_id_scan_wizard.each do |scan_wizard_id, scan_wizard|
              return scan_wizard if scan_wizard_id == needle
            end
          end

          nil
        end

        def find_scan_wizard_id_for_scan_wizard(needle)
          @scan_wizard_id_scan_wizard_semaphore.synchronize do
            @scan_wizard_id_scan_wizard.each do |scan_wizard_id, scan_wizard|
              return scan_wizard_id if scan_wizard == needle
            end
          end

          nil
        end
      end
    end
  end
end