module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # Online Banking UPI transaction class
          class Upi < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::DocumentAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::OnlineBankingPayments::VirtualPaymentAddressAttributes

            attr_accessor :user_category

            protected

            # Upi transaction type
            def transaction_type
              Api::Constants::Transactions::UPI
            end

            # Upi field validations
            def init_field_validations
              super

              required_fields.push *%i[
                transaction_id return_success_url return_failure_url amount currency billing_country
              ]

              field_values.merge! currency: 'INR'
            end

            # Upi parameters structure
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength
              {
                return_success_url:      return_success_url,
                return_failure_url:      return_failure_url,
                customer_email:          customer_email,
                customer_phone:          customer_phone,
                document_id:             document_id,
                virtual_payment_address: virtual_payment_address,
                user_category:           user_category,
                billing_address:         billing_address_parameters_structure,
                shipping_address:        shipping_address_parameters_structure
              }
            end

          end
        end
      end
    end
  end
end
