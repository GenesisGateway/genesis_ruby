module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # Multibanco allows Portuguese shoppers to do payments through the Internet
          # by using virtual credit cards
          class Multibanco < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # Multibanco transaction type
            def transaction_type
              Api::Constants::Transactions::MULTIBANCO
            end

            # Multibanco field validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id return_success_url return_failure_url
                amount currency billing_country]

              field_values.merge! billing_country: %w(PT)
            end

            # Multibanco request structure
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
