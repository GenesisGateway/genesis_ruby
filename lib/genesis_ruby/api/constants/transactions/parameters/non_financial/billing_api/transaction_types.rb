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

                AUTHORISATION_APPROVED                 = 'Authorisation Approved'.freeze
                AUTHORISATION_DECLINED                 = 'Authorisation Declined'.freeze
                SETTLEMENT_APPROVED                    = 'Settlement Approved'.freeze
                SETTLEMENT_DECLINED                    = 'Settlement Declined'.freeze
                SALE_APPROVED                          = 'Sale Approved'.freeze
                SALE_DECLINED                          = 'Sale Declined'.freeze
                REFUND_APPROVED                        = 'Refund Approved'.freeze
                REFUND_DECLINED                        = 'Refund Declined'.freeze
                PAYOUT_APPROVED                        = 'Payout Approved'.freeze
                PAYOUT_DECLINED                        = 'Payout Declined'.freeze
                CFT_OTHER_APPROVED                     = 'CFT Other Approved'.freeze
                CFT_DECLINED                           = 'CFT Declined'.freeze
                CHARGEBACK                             = 'Chargeback'.freeze
                CHARGEBACK_REVERSAL                    = 'Chargeback Reversal'.freeze
                CHARGEBACK_REPRESENTMENT               = 'Chargeback Representment'.freeze
                RETRIEVAL_REQUEST                      = 'Retrieval Request'.freeze
                VOID                                   = 'Void'.freeze
                VISA_EU_INTRAREGIONAL_FRAUD_CHARGEBACK = 'Visa EU Intraregional Fraud Chargeback'.freeze
                MASTERCARD_EU_REGION_CHARGEBACK        = 'MasterCard EU Region Chargeback'.freeze
                SECOND_CHARGEBACK                      = 'Second Chargeback'.freeze
                CFT_VISA_APPROVED                      = 'CFT Visa Approved'.freeze
                CFT_MASTERCARD_APPROVED                = 'CFT MasterCard Approved'.freeze
                VISA_RDR                               = 'Visa RDR'.freeze
                RDR_REVERSAL                           = 'RDR Reversal'.freeze
                GATEWAY_TRANSACTION_FEE                = 'Gateway Transaction Fee'.freeze
                RISK_MANAGEMENT_TRANSACTION_FEE        = 'Risk Management Transaction Fee'.freeze
                FRAUD_ENGINE_TRANSACTION_FEE           = 'Fraud Engine Transaction Fee'.freeze

              end
            end
          end
        end
      end
    end
  end
end
