module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          module InstaDebit
            # InstaDebit Payin transaction - after a successful validation of transaction parameters,
            # transaction status is set to pending async and the consumer is redirected to the
            # InstaDebit consumers page
            class PayIn < Base::Financial

              include Api::Mixins::Requests::AddressInfoAttributes
              include Api::Mixins::Requests::Financial::CustomerAccountAttributes

              attr_reader :return_url

              # Return URL setter
              def return_url=(value)
                unless GenesisRuby::Utils::Common.valid_url?(value)
                  raise ParameterError, "Invalid URL given for #{__method__}"
                end

                @return_url = value
              end

              protected

              # InstaDebit PayIn transaction type
              def transaction_type
                Api::Constants::Transactions::INSTA_DEBIT_PAYIN
              end

              # InstaDebit PayIn field validations
              def init_field_validations
                super

                required_fields.push *%i[transaction_id customer_account_id remote_ip return_url amount
                 currency billing_country]

                field_values.merge! billing_country: 'CA'
              end

              # InstaDebit PayIn parameters structure
              def payment_transaction_structure
                {
                  return_url:          return_url,
                  customer_email:      customer_email,
                  customer_phone:      customer_phone,
                  customer_account_id: customer_account_id,
                  billing_address:     billing_address_parameters_structure,
                  shipping_address:    shipping_address_parameters_structure
                }
              end

            end
          end
        end
      end
    end
  end
end
