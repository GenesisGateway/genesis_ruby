# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Cards
          # Tarjeta Shopping is a cash payment in Argentina
          class TarjetaShopping < Base::Financials::SouthAmericanPayments

            protected

            # Tarjeta Shopping transaction type
            def transaction_type
              Api::Constants::Transactions::TARJETA_SHOPPING
            end

            # Allowed billing countries for Tarjeta Shopping transaction request
            def allowed_billing_countries
              %w(AR)
            end

          end
        end
      end
    end
  end
end
