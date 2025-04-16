require 'genesis_ruby/api/constants/transactions/parameters/wallets/pay_pal/payment_types'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Wallets
          # PayPal transaction is a fast and easy way for buyers to pay with their PayPal account
          class PayPal < Requests::Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::BirthDateAttributes
            include Api::Mixins::Requests::Financial::Business::BusinessAttributes
            include Api::Mixins::Requests::DocumentAttributes
            include Api::Mixins::Requests::Financial::NotificationAttributes
            include Api::Mixins::Requests::Financial::NotificationAttributes
            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            attr_accessor :payment_type

            protected

            # Initialize PayPal request field validations
            def init_field_validations
              super

              required_fields
                .push *%i[transaction_id payment_type amount currency return_success_url return_failure_url]

              field_values.merge! payment_type:
                Api::Constants::Transactions::Parameters::Wallets::PayPal::PaymentTypes.all
            end

            # PayPal transaction type
            def transaction_type
              Api::Constants::Transactions::PAY_PAL
            end

            # PayPal request attributes structure
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength
              {
                notification_url:    notification_url,
                return_success_url:  return_success_url,
                return_failure_url:  return_failure_url,
                return_pending_url:  return_pending_url,
                customer_email:      customer_email,
                customer_phone:      customer_phone,
                payment_type:        payment_type,
                birth_date:          birth_date,
                document_id:         document_id,
                billing_address:     billing_address_parameters_structure,
                shipping_address:    shipping_address_parameters_structure,
                business_attributes: business_attributes_structure
              }
            end

          end
        end
      end
    end
  end
end
