# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # RapiPago from Argentina is an offline payment method used for online purchases
          class RapiPago < Base::Financials::SouthAmericanPayments

            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # RapiPago transaction type
            def transaction_type
              Api::Constants::Transactions::RAPI_PAGO
            end

            # Allowed billing countries for RapiPago transaction request
            def allowed_billing_countries
              %w(AR)
            end

            # RapiPago transaction request structure
            def payment_transaction_structure
              super.merge return_pending_url: return_pending_url
            end

          end
        end
      end
    end
  end
end
