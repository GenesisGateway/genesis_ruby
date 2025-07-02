# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # Sofort, bank transfer payment method, popular in Germany
          class Sofort < Requests::Base::Financial

            include Api::Mixins::Requests::CustomerAddress::BillingInfoAttributes
            include Api::Mixins::Requests::CustomerAddress::ShippingInfoAttributes
            include Api::Mixins::Requests::CustomerAddress::CustomerInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::BankAttributes
            include Api::Mixins::Requests::Financial::PendingPaymentAttributes
            include Api::Mixins::Requests::Financial::NotificationAttributes

            protected

            # Sofort transaction type
            def transaction_type
              Api::Constants::Transactions::SOFORT
            end

            # Sofort field validation
            def init_field_validations # rubocop:disable Metrics/MethodLength
              super

              required_fields.push *%i[
                transaction_id
                remote_ip
                return_success_url
                return_failure_url
                amount
                currency
                customer_email
                billing_country
              ]

              field_values.merge! billing_country: %w(AT BE DE IT NL PL ES CH)
            end

            # Sofort request structure
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength
              {
                notification_url:   notification_url,
                return_success_url: return_success_url,
                return_failure_url: return_failure_url,
                return_pending_url: return_pending_url,
                customer_email:     customer_email,
                customer_phone:     customer_phone,
                iban:               iban,
                bic:                bic,
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
