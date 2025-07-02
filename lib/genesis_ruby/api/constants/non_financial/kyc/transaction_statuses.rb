# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # TransactionStatuses
          class TransactionStatuses

            extend Mixins::Constants::Common

            # Definition of the transaction status
            TRANSACTION_STATUS_UNDEFINED       = 0
            TRANSACTION_STATUS_APPROVED        = 1
            TRANSACTION_STATUS_PRE_AUTH        = 2
            TRANSACTION_STATUS_SETTLED         = 3
            TRANSACTION_STATUS_VOID            = 4
            TRANSACTION_STATUS_REJECTED        = 5
            TRANSACTION_STATUS_DECLINED        = 6
            TRANSACTION_STATUS_CHARGEBACK      = 7
            TRANSACTION_STATUS_RETURN          = 8
            TRANSACTION_STATUS_PENDING         = 9
            TRANSACTION_STATUS_PASS            = 10
            TRANSACTION_STATUS_FAILED          = 11
            TRANSACTION_STATUS_REFUND          = 12
            TRANSACTION_STATUS_APPROVED_REVIEW = 13
            TRANSACTION_STATUS_ABANDON         = 14

          end
        end
      end
    end
  end
end
