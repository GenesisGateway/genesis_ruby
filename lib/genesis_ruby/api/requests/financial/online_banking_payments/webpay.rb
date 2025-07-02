# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # Webpay is a Chilean real-time bank transfer method.
          class Webpay < Base::Financials::SouthAmericanPayments

            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # Webpay transaction type
            def transaction_type
              Api::Constants::Transactions::WEBPAY
            end

            # Allowed billing countries for Webpay transaction request
            def allowed_billing_countries
              %w(CL)
            end

            # Webpay transaction request structure
            def payment_transaction_structure
              super.merge return_pending_url: return_pending_url
            end

          end
        end
      end
    end
  end
end
