# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # MyBank is an overlay banking system for Italy and Spain
          class MyBank < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # MyBank transaction type
            def transaction_type
              Api::Constants::Transactions::MY_BANK
            end

            # MyBank field validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id return_success_url return_failure_url
                amount currency billing_country]

              field_values.merge! currency:        'EUR',
                                  billing_country: %w(IT BE PT ES)
            end

            # MyBank request structure
            def payment_transaction_structure
              {
                return_success_url: return_success_url,
                return_failure_url: return_failure_url,
                return_pending_url: return_pending_url,
                billing_address:    billing_address_parameters_structure,
                shipping_address:   shipping_address_parameters_structure
              }
            end

          end
        end
      end
    end
  end
end
