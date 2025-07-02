# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Mixin Payment Attributes, brings Payment Attributes partial
          module PaymentAttributes

            attr_accessor :amount
            attr_writer   :currency

            # Currency Attribute getter
            def currency
              @currency.to_s.upcase
            end

            protected

            # Returns the Payment Attributes structure with the Genesis Request keys
            def payment_attributes_structure
              {
                amount:   transform_amount(amount, currency),
                currency: currency
              }
            end

          end
        end
      end
    end
  end
end
