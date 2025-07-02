# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/create_transaction_payment_methods'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Deposit Limits Attributes mixin for KYC Non-Financial API services
            module DepositLimitsAttributes

              attr_accessor :minimum, :daily_maximum, :weekly_maximum, :monthly_maximum, :payment_method

              protected

              # Defines required fields for deposit limits
              def deposit_limits_required_fields
                %i[payment_method]
              end

              # Returns the deposit limits structure
              def deposit_limits_structure
                {
                  payment_method:  payment_method,
                  minimum:         minimum,
                  daily_maximum:   daily_maximum,
                  weekly_maximum:  weekly_maximum,
                  monthly_maximum: monthly_maximum
                }
              end

            end
          end
        end
      end
    end
  end
end
