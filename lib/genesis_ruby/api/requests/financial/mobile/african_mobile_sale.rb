require 'genesis_ruby/api/constants/transactions/parameters/african_mobile_operators'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Mobile
          # African Mobile Sale, otherwise known as Charge, is an APM used to process
          # Mobile network operator payments
          class AfricanMobileSale < Requests::Base::Financial

            include Mixins::Requests::AddressInfoAttributes
            include Mixins::Requests::Financial::AfricanMobileAttributes
            include Mixins::Requests::Financial::AsyncAttributes

            protected

            # African Mobile Sale transaction type
            def transaction_type
              Api::Constants::Transactions::AFRICAN_MOBILE_SALE
            end

            # African Mobile Sale field validations
            def init_field_validations # rubocop:disable Metrics/MethodLength
              super

              required_fields.push *%i[transaction_id return_success_url return_failure_url
                amount currency operator target customer_phone billing_country]

              field_values.merge! billing_country: %w(GH KE UG),
                                  currency:        %w(GHS KES UGX),
                                  operator:
                                    Api::Constants::Transactions::Parameters::AfricanMobileOperators.sale

              field_value_dependencies.merge!(
                {
                  currency: {
                    GHS: {
                      billing_country: %w(GH),
                      operator:        [
                        Api::Constants::Transactions::Parameters::AfricanMobileOperators::VODACOM
                      ]
                    },
                    KES: {
                      billing_country: %w(KE),
                      operator:        [
                        Api::Constants::Transactions::Parameters::AfricanMobileOperators::SAFARICOM
                      ]
                    },
                    UGX: {
                      billing_country: %w(UG),
                      operator:        [
                        Api::Constants::Transactions::Parameters::AfricanMobileOperators::AIRTEL,
                        Api::Constants::Transactions::Parameters::AfricanMobileOperators::MTN
                      ]
                    }
                  }
                }
              )
            end

            # African Mobile Sale request structure
            def payment_transaction_structure
              {
                return_success_url: return_success_url,
                return_failure_url: return_failure_url,
                operator:           operator,
                target:             target,
                customer_email:     customer_email,
                customer_phone:     customer_phone,
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
