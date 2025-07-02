# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Crypto
          module BitPay
            # BitPay Refund is a custom refund method which will handle the asynchronous
            # BitPay refund workflow
            class Refund < Requests::Base::Reference

              protected

              # BitPay Refund transaction type
              def transaction_type
                Api::Constants::Transactions::BITPAY_REFUND
              end

              # BitPay Refund field validations
              def init_field_validations
                super

                required_fields.push *%i[transaction_id amount currency reference_id]
              end

              # BitPay Refund parameters structure
              def reference_transaction_structure
                {}
              end

            end
          end
        end
      end
    end
  end
end
