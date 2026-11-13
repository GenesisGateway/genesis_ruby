# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/purpose_of_payment'
require 'genesis_ruby/api/constants/transactions/parameters/purpose_of_payment_values'

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
                attribute:     __method__,
                allowed:       allowed_purpose_of_payment_values,
                value:         value,
                error_message: 'Invalid data for Purpose of Payment',
                allow_empty:   true
              )
            end

            protected

            # Values accepted by the purpose_of_payment setter: the Visa codes and the Visa human-readable values.
            # A request can override the method to widen the list (see Payout)
            def allowed_purpose_of_payment_values
              Api::Constants::Transactions::Parameters::PurposeOfPayment.all +
                Api::Constants::Transactions::Parameters::PurposeOfPaymentValues.all
            end

          end
        end
      end
    end
  end
end
