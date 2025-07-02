# frozen_string_literal: true

module GenesisRuby
  module Utils
    module Transactions
      module References
        # Capturable Transaction Types Helper Methods
        class CapturableTypes

          class << self

            include GenesisRuby::Api::Constants::Transactions

            # Array containing all available Capturable Types
            def all
              [
                APPLE_PAY, AUTHORIZE, AUTHORIZE_3D,
                GOOGLE_PAY,
                INVOICE,
                PAY_PAL
              ]
            end

            # Checks if the given type is allowed for the execution of Reference Capture Transaction Type
            def allowed_reference?(type)
              all.include?(type.to_s.downcase)
            end

            # Checks if the given type is a Capture type
            def valid?(type)
              [
                CAPTURE,
                INVOICE_CAPTURE
              ].include?(type.to_s.downcase)
            end

            # Fetches the correct Transaction type that must be used for the execution of the Capture
            # ex. invoice -> invoice_capture
            def fetch_reference(type)
              case type.to_s.downcase
              when INVOICE
                INVOICE_CAPTURE
              else
                CAPTURE
              end
            end

          end

        end
      end
    end
  end
end
