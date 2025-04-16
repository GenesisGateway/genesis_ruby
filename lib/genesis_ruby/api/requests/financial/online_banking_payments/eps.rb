module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # EPS is the main bank transfer payment method in Austria
          class Eps < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::PendingPaymentAttributes

            protected

            # EPS transaction type
            def transaction_type
              Api::Constants::Transactions::EPS
            end

            # EPS field validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id return_success_url return_failure_url
               amount currency billing_country]
              field_values.merge! currency:        'EUR',
                                  billing_country: 'AT'
            end

            # EPS request structure
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
