# frozen_string_literal: true

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

                ID                                               = 'id'
                BILLING_STATEMENT                                = 'billingStatement'
                UNIQUE_ID                                        = 'uniqueId'
                ARN                                              = 'arn'
                TRANSACTION_DATE                                 = 'transactionDate'
                TRANSACTION_TYPE                                 = 'transactionType'
                TRANSACTION_CURRENCY                             = 'transactionCurrency'
                TRANSACTION_AMOUNT                               = 'transactionAmount'
                EXCHANGE_RATE                                    = 'exchangeRate'
                BILLING_CURRENCY                                 = 'billingCurrency'
                BILLING_AMOUNT                                   = 'billingAmount'
                TRANSACTION_FEE_CURRENCY                         = 'transactionFeeCurrency'
                TRANSACTION_FEE_AMOUNT                           = 'transactionFeeAmount'
                TRANSACTION_FEE_CHARGED_ON_BILLING_STATEMENT     = 'transactionFeeChargedOnBillingStatement'
                COMMISSION_PERCENT                               = 'commissionPercent'
                COMMISSION_AMOUNT                                = 'commissionAmount'
                INTERCHANGE_FEE                                  = 'interchangeFee'
                INTERCHANGE_CURRENCY                             = 'interchangeCurrency'
                IS_INTERCHANGEPLUSPLUS                           = 'isInterchangeplusplus'
                INTERCHANGEPLUSPLUS_CHARGED_ON_BILLING_STATEMENT = 'interchangeplusplusChargedOnBillingStatement'
                SCHEME_FEE                                       = 'schemeFee'
                SCHEME_FEE_CURRENCY                              = 'schemeFeeCurrency'
                STANDARD_DEBIT_CARD_RATE                         = 'standardDebitCardRate'
                GST_AMOUNT                                       = 'gstAmount'
                GST_RATE                                         = 'gstRate'
                VAT_AMOUNT                                       = 'vatAmount'
                VAT_RATE                                         = 'vatRate'
                TERMINAL_NAME                                    = 'terminalName'
                REGION                                           = 'region'
                SETTLEMENT_BILLING_STATEMENTS                    = 'settlementBillingStatements'
                SETTLEMENT_DATES                                 = 'settlementDates'
                SETTLEMENT_STATUS                                = 'settlementStatus'
                MERCHANT_ID                                      = 'merchantId'
                MERCHANT_NAME                                    = 'merchantName'
                MERCHANT_TRANSACTION_ID                          = 'merchantTransactionId'
                MASTER_ACCOUNT_NAME                              = 'masterAccountName'
                VALUE_DATE                                       = 'valueDate'
                DOCUMENT_ID                                      = 'documentId'
                REFERENCE_ID                                     = 'referenceId'
                AUTH_CODE                                        = 'authCode'
                PAYMENT_TYPE                                     = 'paymentType'
                CARD_BRAND                                       = 'cardBrand'
                CARD_NUMBER                                      = 'cardNumber'
                CARD_HOLDER                                      = 'cardHolder'
                CARD_TYPE                                        = 'cardType'
                CARD_SUBTYPE                                     = 'cardSubtype'

              end
            end
          end
        end
      end
    end
  end
end
