require 'genesis_ruby/api/constants/transactions/parameters/purpose_of_payment'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Purpose of Payment Attributes
          module PurposeOfPaymentAttributes

            attr_reader :purpose_of_payment

            # Purpose of Payment setter
            def purpose_of_payment=(value)
              allowed_options(
                attribute: __method__,
                allowed: GenesisRuby::Api::Constants::Transactions::Parameters::PurposeOfPayment.all,
                value: value,
                error_message: 'Invalid data for Purpose of Payment',
                allow_empty: true
              )
            end

          end
        end
      end
    end
  end
end
