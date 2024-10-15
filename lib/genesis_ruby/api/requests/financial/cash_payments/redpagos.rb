module GenesisRuby
  module Api
    module Requests
      module Financial
        module CashPayments
          # Redpagos is a cash payment in Uruguay
          class Redpagos < Base::Financials::SouthAmericanPayments

            protected

            # Redpagos transaction type
            def transaction_type
              Api::Constants::Transactions::REDPAGOS
            end

            # Allowed billing countries for Redpagos transaction request
            def allowed_billing_countries
              %w(UY)
            end

          end
        end
      end
    end
  end
end
