# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Wallets
          # Alipay is an oBeP-style alternative payment method that allows you to pay directly with your ebank account.
          class Alipay < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::BirthDateAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes

            protected

            # Alipay transaction type
            def transaction_type
              Api::Constants::Transactions::ALIPAY
            end

            # Alipay Field Validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id amount currency return_success_url return_failure_url]
              field_values.merge! currency: %w(EUR CNY)
            end

            # Alipay request structure
            def payment_transaction_structure
              {
                return_success_url: return_success_url,
                return_failure_url: return_failure_url,
                customer_email:     customer_email,
                customer_phone:     customer_phone,
                birth_date:         birth_date,
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
