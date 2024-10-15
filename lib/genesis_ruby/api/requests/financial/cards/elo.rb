module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Elo is a local Brazilian payment card.
          class Elo < Base::Financials::SouthAmericanPayments

            protected

            # Elo transaction type
            def transaction_type
              Api::Constants::Transactions::ELO
            end

            # Allowed billing countries for Elo transaction request
            def allowed_billing_countries
              %w(BR)
            end

          end
        end
      end
    end
  end
end
