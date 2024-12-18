module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Cabal is a local debit/credit card brand in Argentina which can be used for online purchases.
          class Cabal < Base::Financials::SouthAmericanPayments

            protected

            # Cabal transaction type
            def transaction_type
              Api::Constants::Transactions::CABAL
            end

            # Allowed billing countries for Cabal transaction type
            def allowed_billing_countries
              %w(AR)
            end

          end
        end
      end
    end
  end
end
