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

                BILLING_STATEMENT      = 'billingStatement'.freeze
                TRANSACTION_DATE       = 'transactionDate'.freeze
                TRANSACTION_CURRENCY   = 'transactionCurrency'.freeze
                TRANSACTION_AMOUNT     = 'transactionAmount'.freeze
                EXCHANGE_RATE          = 'exchangeRate'.freeze
                BILLING_AMOUNT         = 'billingAmount'.freeze
                TRANSACTION_FEE_AMOUNT = 'transactionFeeAmount'.freeze
                COMMISSION_PERCENT     = 'commissionPercent'.freeze
                COMMISSION_AMOUNT      = 'commissionAmount'.freeze
                INTERCHANGE_FEE        = 'interchangeFee'.freeze
                REGION                 = 'region'.freeze
                SETTLEMENT_STATUS      = 'settlementStatus'.freeze

              end
            end
          end
        end
      end
    end
  end
end
