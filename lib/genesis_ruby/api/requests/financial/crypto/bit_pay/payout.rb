module GenesisRuby
  module Api
    module Requests
      module Financial
        module Crypto
          module BitPay
            # BitPay Payout is a crypto currency payout method where merchants are requesting payouts
            # in FIAT currency and the funds are transferred in Bitcoin equivalent to a crypto wallet address
            class Payout < Requests::Base::Financial

              include Api::Mixins::Requests::AddressInfoAttributes
              include Api::Mixins::Requests::Financial::AsyncAttributes
              include Api::Mixins::Requests::Financial::NotificationAttributes

              attr_accessor :crypto_address, :crypto_wallet_provider

              protected

              # BitPay Payout transaction type
              def transaction_type
                Api::Constants::Transactions::BITPAY_PAYOUT
              end

              # BitPay Payout field validations
              def init_field_validations
                super

                required_fields.push *%i[transaction_id notification_url return_success_url
                  return_failure_url amount currency crypto_address crypto_wallet_provider]
              end

              # BitPay Payout parameters structure
              def payment_transaction_structure
                {
                  notification_url:       notification_url,
                  return_success_url:     return_success_url,
                  return_failure_url:     return_failure_url,
                  customer_email:         customer_email,
                  crypto_address:         crypto_address,
                  crypto_wallet_provider: crypto_wallet_provider,
                  billing_address:        billing_address_parameters_structure,
                  shipping_address:       shipping_address_parameters_structure
                }
              end

            end
          end
        end
      end
    end
  end
end
