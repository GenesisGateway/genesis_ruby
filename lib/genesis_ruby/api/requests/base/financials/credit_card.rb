module GenesisRuby
  module Api
    module Requests
      module Base
        module Financials
          # Base Class used for all transaction request containing Credit Card data
          class CreditCard < GenesisRuby::Api::Requests::Base::Financial

            include Mixins::Requests::Financial::PaymentAttributes
            include Mixins::Requests::Financial::Cards::CreditCardAttributes
            include Mixins::Requests::Financial::Cards::TokenizationAttributes

            protected

            # Credit Card attributes
            def payment_transaction_structure
              payment_attributes_structure.merge credit_card_attributes_structure, tokenization_attributes_structure
            end

          end
        end
      end
    end
  end
end
