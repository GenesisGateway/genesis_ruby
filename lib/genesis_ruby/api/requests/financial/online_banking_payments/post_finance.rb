# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # PostFinance is an online banking provider in Switzerland
          class PostFinance < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # PostFinance transaction type
            def transaction_type
              Api::Constants::Transactions::POST_FINANCE
            end

            # PostFinance field validations
            def init_field_validations # rubocop:disable Metrics/MethodLength
              super

              required_fields.push *%i[
                transaction_id
                return_success_url
                return_failure_url
                amount
                currency
                billing_country
              ]

              field_values.merge! currency:        %w(EUR CHF),
                                  billing_country: 'CH'
            end

            # PostFinance request structure
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
