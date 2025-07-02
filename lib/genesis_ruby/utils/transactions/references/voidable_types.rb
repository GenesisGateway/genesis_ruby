# frozen_string_literal: true

module GenesisRuby
  module Utils
    module Transactions
      module References
        # Voidable Transaction Types Helper Methods
        class VoidableTypes

          class << self

            include GenesisRuby::Api::Constants::Transactions

            # Array containing all available Voidable Types
            def all
              [
                AFRICAN_MOBILE_PAYOUT, AFRICAN_MOBILE_SALE, APPLE_PAY, AUTHORIZE, AUTHORIZE_3D,
                FASHIONCHEQUE,
                GOOGLE_PAY,
                INTERSOLVE, INVOICE,
                PAY_PAL,
                REFUND,
                SALE, SALE_3D,
                TCS, TRUSTLY_SALE
              ]
            end

            # Checks if the given type is allowed for the execution of Reference Void Transaction Type
            def allowed_reference?(type)
              all.include?(type.to_s.downcase)
            end

            # Checks if the given type is a Void type
            def valid?(type)
              [
                VOID
              ].include?(type.to_s.downcase)
            end

            # Fetches the correct Transaction type that must be used for the execution of the Void
            def fetch_reference(_type)
              VOID
            end

          end

        end
      end
    end
  end
end
