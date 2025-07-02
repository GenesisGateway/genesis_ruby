# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Crypto
          module BitPay
            # BitPay is a cryptocurrency payments provider supporting blockchain payments
            # with Bitcoin (BTC) and BitcoinCash (BCH)
            # BitPay Sale is an asynchronous transaction type
            class Sale < Requests::Base::Financial

              include Api::Mixins::Requests::AddressInfoAttributes

              attr_reader :return_url

              # Return URL setter
              def return_url=(value)
                unless GenesisRuby::Utils::Common.valid_url?(value)
                  raise ParameterError, "Invalid URL given for #{__method__}"
                end

                @return_url = value
              end

              protected

              # BitPay Sale transaction type
              def transaction_type
                Api::Constants::Transactions::BITPAY_SALE
              end

              # BitPay Sale field validations
              def init_field_validations
                super

                required_fields.push *%i[transaction_id return_url amount currency customer_email]
              end

              # BitPay Sale parameters structure
              def payment_transaction_structure
                {
                  return_url:       return_url,
                  customer_email:   customer_email,
                  billing_address:  billing_address_parameters_structure,
                  shipping_address: shipping_address_parameters_structure
                }
              end

            end
          end
        end
      end
    end
  end
end
