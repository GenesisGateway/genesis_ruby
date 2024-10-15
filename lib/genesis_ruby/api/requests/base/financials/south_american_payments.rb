module GenesisRuby
  module Api
    module Requests
      module Base
        module Financials
          # South American Payments base class
          class SouthAmericanPayments < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes
            include Api::Mixins::Requests::BirthDateAttributes
            include Api::Mixins::Requests::Financial::PaymentAttributes
            include Api::Mixins::Requests::Financial::ConsumerIdentifierAttributes

            # Billing Country custom accessor
            def billing_country
              return nil unless @billing_country

              @billing_country.to_s.upcase
            end

            protected

            # Defines allowed billing countries
            def allowed_billing_countries
              raise NoMethodError, 'South American Payment requests require definition of allowed billing countries'
            end

            def init_field_validations
              super

              required_fields.push *%i[transaction_id return_success_url return_failure_url amount currency
                consumer_reference national_id customer_email billing_country]

              field_values.merge! billing_country: allowed_billing_countries
            end

            # South American payments
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength
              payment_attributes_structure.merge(
                {
                  return_success_url: return_success_url,
                  return_failure_url: return_failure_url,
                  consumer_reference: consumer_reference,
                  national_id:        national_id,
                  birth_date:         birth_date,
                  customer_email:     customer_email,
                  billing_address:    billing_address_parameters_structure,
                  shipping_address:   shipping_address_parameters_structure
                }
              )
            end

          end
        end
      end
    end
  end
end
