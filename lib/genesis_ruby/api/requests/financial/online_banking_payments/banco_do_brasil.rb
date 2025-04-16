module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          #  Banco do Brasil offers online bank transfer payment service
          class BancoDoBrasil < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::Financial::PendingPaymentAttributes
            include Api::Mixins::Requests::BirthDateAttributes
            include Api::Mixins::Requests::Financial::ConsumerIdentifierAttributes

            protected

            # Banco do Brasil transaction type
            def transaction_type
              Api::Constants::Transactions::BANCO_DO_BRASIL
            end

            # Allowed billing country for Banco do Brasil transaction request
            def allowed_billing_countries
              %w(BR)
            end

            # Banco Do Brasil field validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id return_success_url return_failure_url
               amount currency consumer_reference national_id customer_email billing_country]

              field_values.merge! billing_country: allowed_billing_countries
            end

            # Banco do Brasil request structure
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength
              {
                return_success_url: return_success_url,
                return_failure_url: return_failure_url,
                return_pending_url: return_pending_url,
                consumer_reference: consumer_reference,
                national_id:        national_id,
                birth_date:         birth_date,
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
