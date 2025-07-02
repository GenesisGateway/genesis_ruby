# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module CashPayments
          # Efecty is a cash-based payment method.
          class Efecty < Base::Financials::SouthAmericanPayments

            protected

            # Efecty transaction type
            def transaction_type
              Api::Constants::Transactions::EFECTY
            end

            # Allowed billing countries for Efecty transaction request
            def allowed_billing_countries
              %w(CO)
            end

          end
        end
      end
    end
  end
end
