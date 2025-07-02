# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # PSE (Pagos Seguros en Linea) is the preferred alternative payment solution in Colombia.
          class Pse < Base::Financials::SouthAmericanPayments

            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # PSE (Pagos Seguros en Linea) transaction type
            def transaction_type
              Api::Constants::Transactions::PSE
            end

            # Allowed billing countries for PSE (Pagos Seguros en Linea) transaction request
            def allowed_billing_countries
              %w(CO)
            end

            # PSE (Pagos Seguros en Linea) transaction request structure
            def payment_transaction_structure
              super.merge return_pending_url: return_pending_url
            end

          end
        end
      end
    end
  end
end
