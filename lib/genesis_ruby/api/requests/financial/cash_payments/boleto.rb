module GenesisRuby
  module Api
    module Requests
      module Financial
        module CashPayments
          # Boleto is a payment service in Brazil
          class Boleto < Base::Financials::SouthAmericanPayments

            protected

            # Boleto transaction type
            def transaction_type
              Api::Constants::Transactions::BOLETO
            end

            # Allowed billing country for Boleto transaction request
            def allowed_billing_countries
              %w(BR)
            end

          end
        end
      end
    end
  end
end
