module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # Davivienda is offering the Bill pay service which is a fast, easy and secure way to pay and manage your
          # bills online to anyone, anytime in Colombia.
          class Davivienda < Base::Financials::SouthAmericanPayments

            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # Davivienda transaction type
            def transaction_type
              Api::Constants::Transactions::DAVIVIENDA
            end

            # Allowed billing countries for Davivienda transaction request
            def allowed_billing_countries
              %w(CO)
            end

            # Davivienda payment transaction structure
            def payment_transaction_structure
              super.merge return_pending_url: return_pending_url
            end

          end
        end
      end
    end
  end
end
