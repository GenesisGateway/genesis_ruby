# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module CashPayments
          # Banco de Occidente is a cash payment method for Colombia
          class BancoDeOccidente < Base::Financials::SouthAmericanPayments

            protected

            # Banco de Occidente transaction type
            def transaction_type
              Api::Constants::Transactions::BANCO_DE_OCCIDENTE
            end

            # Banco de Occidente allowed billing countries
            def allowed_billing_countries
              %w(CO)
            end

          end
        end
      end
    end
  end
end
