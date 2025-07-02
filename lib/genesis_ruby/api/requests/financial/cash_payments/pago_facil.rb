# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module CashPayments
          # Pago Facil is a cash-based payment used for online purchases
          class PagoFacil < Base::Financials::SouthAmericanPayments

            protected

            # PagoFacil transaction type
            def transaction_type
              Api::Constants::Transactions::PAGO_FACIL
            end

            # Allowed billing countries for PagoFacil transaction request
            def allowed_billing_countries
              %w(AR)
            end

          end
        end
      end
    end
  end
end
