module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Cencosud is a local credit card in Argentina
          class Cencosud < Base::Financials::SouthAmericanPayments

            protected

            # Cencosud transaction type
            def transaction_type
              Api::Constants::Transactions::CENCOSUD
            end

            # Allowed billing countries for Cencosud transaction request
            def allowed_billing_countries
              %w(AR)
            end

          end
        end
      end
    end
  end
end
