# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # Source of Funds
          class SourceOfFunds

            extend Mixins::Constants::Common

            # Source of Funds Credit
            CREDIT               = 'credit'

            # Source of Funds Debit
            DEBIT                = 'debit'

            # Source of Funds Prepaid
            PREPAID              = 'prepaid'

            # Source of Funds Cash
            CASH                 = 'cash'

            # Source of Funds Other Debit Account
            OTHER_DEBIT_ACCOUNT  = 'other_debit_account'

            # Source of funds Other Credit Account
            OTHER_CREDIT_ACCOUNT = 'other_credit_account'

          end
        end
      end
    end
  end
end
