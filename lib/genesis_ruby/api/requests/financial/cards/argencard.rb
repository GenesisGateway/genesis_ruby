module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Argencard is a debit or credit card used in Argentina.
          class Argencard < Base::Financials::SouthAmericanPayments

            protected

            # Argencard transaction type
            def transaction_type
              Api::Constants::Transactions::ARGENCARD
            end

            # Argencard allowed billing countries
            def allowed_billing_countries
              %w(AR)
            end

          end
        end
      end
    end
  end
end
