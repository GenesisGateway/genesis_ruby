module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # Bradesco is a payment service in Brazil
          class Bradesco < Base::Financials::SouthAmericanPayments

            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # Bradesco transaction type
            def transaction_type
              Api::Constants::Transactions::BRADESCO
            end

            # Allowed billing countries for Bradesco transaction type
            def allowed_billing_countries
              %w(BR)
            end

            # Bradesco request structure
            def payment_transaction_structure
              super.merge return_pending_url: return_pending_url
            end

          end
        end
      end
    end
  end
end
