# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # CreateTransactionPaymentMethods helper class
          class CreateTransactionPaymentMethods

            extend Mixins::Constants::Common

            # Valid payment methods: "CC" (Credit Card), "CC_OPTIONAL" (Credit card optional) or "EC" (Echeck)
            PAYMENT_METHOD_CC          = 'CC'
            PAYMENT_METHOD_CC_OPTIONAL = 'CC_OPTIONAL'
            PAYMENT_METHOD_EC          = 'EC'

          end
        end
      end
    end
  end
end
