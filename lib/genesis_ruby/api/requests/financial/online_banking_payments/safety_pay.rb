# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # SafetyPay, bank transfer payment method, popular in Germany
          class SafetyPay < Requests::Base::Financial

            include Api::Mixins::Requests::CustomerAddress::BillingInfoAttributes
            include Api::Mixins::Requests::CustomerAddress::ShippingInfoAttributes
            include Api::Mixins::Requests::CustomerAddress::CustomerInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # SafetyPay transaction type
            def transaction_type
              Api::Constants::Transactions::SAFETYPAY
            end

            # SafetyPay field validation
            def init_field_validations # rubocop:disable Metrics/MethodLength
              super

              required_fields.push *%i[
                transaction_id
                return_success_url
                return_failure_url
                amount
                currency
                customer_email
                billing_country
              ]

              field_values.merge! currency:        %w(EUR USD),
                                  billing_country: %w(AT BE BR CL CO DE EC ES MX NL PE PR)
            end

            # SafetyPay request structure
            def payment_transaction_structure
              {
                return_success_url: return_success_url,
                return_failure_url: return_failure_url,
                return_pending_url: return_pending_url,
                customer_email:     customer_email,
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
