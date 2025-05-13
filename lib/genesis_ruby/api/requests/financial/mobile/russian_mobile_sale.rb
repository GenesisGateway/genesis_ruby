require 'genesis_ruby/api/constants/transactions/parameters/mobile/apple_pay/payment_subtypes'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Mobile
          # Russian Mobile Sale, otherwise known as Charge, is an APM used
          # to process Mobile network operator payments
          class RussianMobileSale < Requests::Base::Financial

            include Mixins::Requests::AddressInfoAttributes
            include Mixins::Requests::Financial::AsyncAttributes

            attr_accessor :target, :operator

            protected

            # Russian Mobile Sale transaction type
            def transaction_type
              Api::Constants::Transactions::RUSSIAN_MOBILE_SALE
            end

            # Russian Mobile Sale field validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id usage return_success_url return_failure_url
                amount currency operator target customer_phone billing_country]

              field_values.merge! billing_country: %w(RU),
                                  currency:        %w(RUB),
                                  operator:        %w(mtc megafon tele2 beeline)
            end

            # Russian Mobile Sale request structure
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
