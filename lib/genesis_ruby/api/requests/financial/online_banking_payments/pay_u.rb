module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # PayU is a payment method for Czech Republic and Poland
          class PayU < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # PayU transaction type
            def transaction_type
              Api::Constants::Transactions::PAYU
            end

            # PayU field validations
            def init_field_validations # rubocop:disable Metrics/MethodLength
              super

              required_fields.push *%i[transaction_id return_success_url return_failure_url
               amount currency billing_first_name billing_last_name billing_country]

              field_values.merge! billing_country: %w(CZ PL),
                                  currency:        %w(CZK PLN)

              field_value_dependencies.merge!(
                {
                  currency: {
                    CZK: {
                      billing_country: %w(CZ)
                    },
                    PLN: {
                      billing_country: %w(PL)
                    }
                  }
                }
              )
            end

            # PayU request structure
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
