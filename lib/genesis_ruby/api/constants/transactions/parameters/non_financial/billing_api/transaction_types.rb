# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            module BillingApi
              # Billing API Transaction Types allowed values
              class TransactionTypes

                extend Mixins::Constants::Common

                AUTHORISATION_APPROVED                 = 'Authorisation Approved'
                AUTHORISATION_DECLINED                 = 'Authorisation Declined'
                SETTLEMENT_APPROVED                    = 'Settlement Approved'
                SETTLEMENT_DECLINED                    = 'Settlement Declined'
                SALE_APPROVED                          = 'Sale Approved'
                SALE_DECLINED                          = 'Sale Declined'
                REFUND_APPROVED                        = 'Refund Approved'
                REFUND_DECLINED                        = 'Refund Declined'
                PAYOUT_APPROVED                        = 'Payout Approved'
                PAYOUT_DECLINED                        = 'Payout Declined'
                CFT_OTHER_APPROVED                     = 'CFT Other Approved'
                CFT_DECLINED                           = 'CFT Declined'
                CHARGEBACK                             = 'Chargeback'
                CHARGEBACK_REVERSAL                    = 'Chargeback Reversal'
                CHARGEBACK_REPRESENTMENT               = 'Chargeback Representment'
                RETRIEVAL_REQUEST                      = 'Retrieval Request'
                VOID                                   = 'Void'
                VISA_EU_INTRAREGIONAL_FRAUD_CHARGEBACK = 'Visa EU Intraregional Fraud Chargeback'
                MASTERCARD_EU_REGION_CHARGEBACK        = 'MasterCard EU Region Chargeback'
                SECOND_CHARGEBACK                      = 'Second Chargeback'
                CFT_VISA_APPROVED                      = 'CFT Visa Approved'
                CFT_MASTERCARD_APPROVED                = 'CFT MasterCard Approved'
                VISA_RDR                               = 'Visa RDR'
                RDR_REVERSAL                           = 'RDR Reversal'
                GATEWAY_TRANSACTION_FEE                = 'Gateway Transaction Fee'
                RISK_MANAGEMENT_TRANSACTION_FEE        = 'Risk Management Transaction Fee'
                FRAUD_ENGINE_TRANSACTION_FEE           = 'Fraud Engine Transaction Fee'

              end
            end
          end
        end
      end
    end
  end
end
