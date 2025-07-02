# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Payout
          # Global Payout is a transaction type based on Open Banking APIs, used for initiating bank payments
          class GlobalPayout < Base::Financial

            include Api::Mixins::Requests::CustomerAddress::BillingInfoAttributes

            attr_accessor :payee_account_id

            protected

            # Request transaction type
            def transaction_type
              Api::Constants::Transactions::GLOBAL_PAYOUT
            end

            # Request field validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id amount currency payee_account_id]
            end

            # Request structure
            def payment_transaction_structure
              {
                payee_account_id: payee_account_id,
                billing_address:  billing_address_parameters_structure
              }
            end

          end
        end
      end
    end
  end
end
