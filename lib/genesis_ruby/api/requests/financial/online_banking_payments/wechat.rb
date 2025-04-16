module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          # WeChat Pay solution offers merchants access to the over 300 million
          # WeChat users that have linked payment accounts to their WeChat account
          class Wechat < Base::Financial

            include Api::Mixins::Requests::AddressInfoAttributes
            include Api::Mixins::Requests::Financial::AsyncAttributes

            attr_accessor :product_code, :product_num, :product_desc

            protected

            # WeChat transaction type
            def transaction_type
              Api::Constants::Transactions::WECHAT
            end

            # WeChat field validations
            def init_field_validations
              super

              required_fields.push *%i[transaction_id usage return_success_url return_failure_url
               amount currency billing_country]
            end

            # WeChat transaction request structure
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength
              {
                return_success_url: return_success_url,
                return_failure_url: return_failure_url,
                product_code:       product_code,
                product_num:        product_num,
                product_desc:       product_desc,
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
