module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # Source of Funds
          class SourceOfFunds

            extend Mixins::Constants::Common

            # Source of Funds Credit
            CREDIT               = 'credit'.freeze

            # Source of Funds Debit
            DEBIT                = 'debit'.freeze

            # Source of Funds Prepaid
            PREPAID              = 'prepaid'.freeze

            # Source of Funds Cash
            CASH                 = 'cash'.freeze

            # Source of Funds Other Debit Account
            OTHER_DEBIT_ACCOUNT  = 'other_debit_account'.freeze

            # Source of funds Other Credit Account
            OTHER_CREDIT_ACCOUNT = 'other_credit_account'.freeze

          end
        end
      end
    end
  end
end
