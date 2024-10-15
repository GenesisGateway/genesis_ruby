module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # Itau is a real-time online bank transfer method and a virtual card.
          class Itau < Base::Financials::SouthAmericanPayments

            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # Itau transaction type
            def transaction_type
              Api::Constants::Transactions::ITAU
            end

            # Allowed billing countries for Itau transaction request
            def allowed_billing_countries
              %w(BR)
            end

            # Itau payment transaction structure
            def payment_transaction_structure
              super.merge return_pending_url: return_pending_url
            end

          end
        end
      end
    end
  end
end
