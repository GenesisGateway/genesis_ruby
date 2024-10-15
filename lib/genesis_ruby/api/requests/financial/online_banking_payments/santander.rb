module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # Santander is an online bank transfer for ecommerce purchases
          class Santander < Base::Financials::SouthAmericanPayments

            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # Santander transaction type
            def transaction_type
              Api::Constants::Transactions::SANTANDER
            end

            # Allowed billing countries for Santander transaction request
            def allowed_billing_countries
              %w(AR BR MX CL)
            end

            # Santander payment transaction structure
            def payment_transaction_structure
              super.merge return_pending_url: return_pending_url
            end

          end
        end
      end
    end
  end
end
