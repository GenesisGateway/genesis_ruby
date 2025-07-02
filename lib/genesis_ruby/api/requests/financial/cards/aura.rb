# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Aura is a local Brazilian credit card.
          class Aura < Base::Financials::SouthAmericanPayments

            protected

            # Aura transaction type
            def transaction_type
              Api::Constants::Transactions::AURA
            end

            # Allowed Billing Countries for Aura transaction request
            def allowed_billing_countries
              %w(BR)
            end

          end
        end
      end
    end
  end
end
