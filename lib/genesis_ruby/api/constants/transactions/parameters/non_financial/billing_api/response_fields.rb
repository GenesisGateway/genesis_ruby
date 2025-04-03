module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            module BillingApi
              # Billing API Response Fields allowed values
              class ResponseFields

                extend Mixins::Constants::Common

                ID                                               = 'id'.freeze
                BILLING_STATEMENT                                = 'billingStatement'.freeze
                UNIQUE_ID                                        = 'uniqueId'.freeze
                ARN                                              = 'arn'.freeze
                TRANSACTION_DATE                                 = 'transactionDate'.freeze
                TRANSACTION_TYPE                                 = 'transactionType'.freeze
                TRANSACTION_CURRENCY                             = 'transactionCurrency'.freeze
                TRANSACTION_AMOUNT                               = 'transactionAmount'.freeze
                EXCHANGE_RATE                                    = 'exchangeRate'.freeze
                BILLING_CURRENCY                                 = 'billingCurrency'.freeze
                BILLING_AMOUNT                                   = 'billingAmount'.freeze
                TRANSACTION_FEE_CURRENCY                         = 'transactionFeeCurrency'.freeze
                TRANSACTION_FEE_AMOUNT                           = 'transactionFeeAmount'.freeze
                TRANSACTION_FEE_CHARGED_ON_BILLING_STATEMENT     = 'transactionFeeChargedOnBillingStatement'.freeze
                COMMISSION_PERCENT                               = 'commissionPercent'.freeze
                COMMISSION_AMOUNT                                = 'commissionAmount'.freeze
                INTERCHANGE_FEE                                  = 'interchangeFee'.freeze
                INTERCHANGE_CURRENCY                             = 'interchangeCurrency'.freeze
                IS_INTERCHANGEPLUSPLUS                           = 'isInterchangeplusplus'.freeze
                INTERCHANGEPLUSPLUS_CHARGED_ON_BILLING_STATEMENT = 'interchangeplusplusChargedOnBillingStatement'.freeze
                SCHEME_FEE                                       = 'schemeFee'.freeze
                SCHEME_FEE_CURRENCY                              = 'schemeFeeCurrency'.freeze
                STANDARD_DEBIT_CARD_RATE                         = 'standardDebitCardRate'.freeze
                GST_AMOUNT                                       = 'gstAmount'.freeze
                GST_RATE                                         = 'gstRate'.freeze
                VAT_AMOUNT                                       = 'vatAmount'.freeze
                VAT_RATE                                         = 'vatRate'.freeze
                TERMINAL_NAME                                    = 'terminalName'.freeze
                REGION                                           = 'region'.freeze
                SETTLEMENT_BILLING_STATEMENTS                    = 'settlementBillingStatements'.freeze
                SETTLEMENT_DATES                                 = 'settlementDates'.freeze
                SETTLEMENT_STATUS                                = 'settlementStatus'.freeze
                MERCHANT_ID                                      = 'merchantId'.freeze
                MERCHANT_NAME                                    = 'merchantName'.freeze
                MERCHANT_TRANSACTION_ID                          = 'merchantTransactionId'.freeze
                MASTER_ACCOUNT_NAME                              = 'masterAccountName'.freeze
                VALUE_DATE                                       = 'valueDate'.freeze
                DOCUMENT_ID                                      = 'documentId'.freeze
                REFERENCE_ID                                     = 'referenceId'.freeze
                AUTH_CODE                                        = 'authCode'.freeze
                PAYMENT_TYPE                                     = 'paymentType'.freeze
                CARD_BRAND                                       = 'cardBrand'.freeze
                CARD_NUMBER                                      = 'cardNumber'.freeze
                CARD_HOLDER                                      = 'cardHolder'.freeze
                CARD_TYPE                                        = 'cardType'.freeze
                CARD_SUBTYPE                                     = 'cardSubtype'.freeze

              end
            end
          end
        end
      end
    end
  end
end
