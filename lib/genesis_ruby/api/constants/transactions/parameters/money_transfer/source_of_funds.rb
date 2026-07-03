# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module MoneyTransfer
            # Money Transfer Source of Funds
            class SourceOfFunds

              extend Mixins::Constants::Common

              # Current account
              CURRENT_ACCOUNT      = 'current_account'

              # Credit card
              CREDIT_CARD          = 'credit_card'

              # Savings account
              SAVINGS_ACCOUNT      = 'savings_account'

              # Deposit account
              DEPOSIT_ACCOUNT      = 'deposit_account'

              # Cash
              CASH                 = 'cash'

              # Prepaid
              PREPAID              = 'prepaid'

              # Other debit account
              OTHER_DEBIT_ACCOUNT  = 'other_debit_account'

              # Other credit account
              OTHER_CREDIT_ACCOUNT = 'other_credit_account'

            end
          end
        end
      end
    end
  end
end
