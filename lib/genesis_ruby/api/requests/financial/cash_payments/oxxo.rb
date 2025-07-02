# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module CashPayments
          # OXXO is the preferred payment method in Mexico
          class Oxxo < Base::Financials::SouthAmericanPayments

            protected

            # OXXO transaction type
            def transaction_type
              Api::Constants::Transactions::OXXO
            end

            # Allowed billing countries for OXXO transaction request
            def allowed_billing_countries
              %w(MX)
            end

          end
        end
      end
    end
  end
end
