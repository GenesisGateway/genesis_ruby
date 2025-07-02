# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Nativa is an Argentinian credit card provided by the National Bank of Argentina.
          class Nativa < Base::Financials::SouthAmericanPayments

            protected

            # Nativa transaction type
            def transaction_type
              Api::Constants::Transactions::NATIVA
            end

            # Allowed billing countries for Nativa transaction request
            def allowed_billing_countries
              %w(AR)
            end

          end
        end
      end
    end
  end
end
