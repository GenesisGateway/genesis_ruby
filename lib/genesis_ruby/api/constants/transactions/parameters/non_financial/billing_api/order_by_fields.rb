# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            module BillingApi
              # Billing API Order By Field allowed values
              class OrderByFields

                extend Mixins::Constants::Common

                BILLING_STATEMENT      = 'billingStatement'
                TRANSACTION_DATE       = 'transactionDate'
                TRANSACTION_CURRENCY   = 'transactionCurrency'
                TRANSACTION_AMOUNT     = 'transactionAmount'
                EXCHANGE_RATE          = 'exchangeRate'
                BILLING_AMOUNT         = 'billingAmount'
                TRANSACTION_FEE_AMOUNT = 'transactionFeeAmount'
                COMMISSION_PERCENT     = 'commissionPercent'
                COMMISSION_AMOUNT      = 'commissionAmount'
                INTERCHANGE_FEE        = 'interchangeFee'
                REGION                 = 'region'
                SETTLEMENT_STATUS      = 'settlementStatus'

              end
            end
          end
        end
      end
    end
  end
end
