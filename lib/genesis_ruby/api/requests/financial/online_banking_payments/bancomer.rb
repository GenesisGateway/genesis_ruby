# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # Bancomer offers two options for payments in Mexico, cash payment and bank transfer
          class Bancomer < Base::Financials::SouthAmericanPayments

            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # Bancomer transaction type
            def transaction_type
              Api::Constants::Transactions::BANCOMER
            end

            # Allowed billing country for Bancomer transaction request
            def allowed_billing_countries
              %w(MX)
            end

            # Bancomer request structure
            def payment_transaction_structure
              super.merge return_pending_url: return_pending_url
            end

          end
        end
      end
    end
  end
end
