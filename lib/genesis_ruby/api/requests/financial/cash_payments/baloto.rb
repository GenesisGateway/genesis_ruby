# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module CashPayments
          # Baloto is a cash payment option in Colombia.
          class Baloto < Base::Financials::SouthAmericanPayments

            protected

            # Baloto transaction type
            def transaction_type
              Api::Constants::Transactions::BALOTO
            end

            # Baloto allowed billing countries
            def allowed_billing_countries
              %w(CO)
            end

          end
        end
      end
    end
  end
end
