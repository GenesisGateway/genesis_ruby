module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Naranja is a local credit card issued in Argentina which can be used for purchases over the internet.
          class Naranja < Base::Financials::SouthAmericanPayments

            protected

            # Naranja transaction type
            def transaction_type
              Api::Constants::Transactions::NARANJA
            end

            # Allowed billing countries for Naranja transaction request
            def allowed_billing_countries
              %w(AR)
            end

          end
        end
      end
    end
  end
end
