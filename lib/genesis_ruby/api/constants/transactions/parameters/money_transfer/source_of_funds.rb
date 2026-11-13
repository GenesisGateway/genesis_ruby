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

              # Credit
              CREDIT          = 'credit'

              # Debit
              DEBIT           = 'debit'

              # Prepaid
              PREPAID         = 'prepaid'

              # Cash
              CASH            = 'cash'

              # Deposit account
              DEPOSIT_ACCOUNT = 'deposit_account'

            end
          end
        end
      end
    end
  end
end
