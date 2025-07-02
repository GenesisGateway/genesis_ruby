# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module OnlineBanking
            # Bank Payout Account Types allowed values
            class BankAccountTypes

              extend Mixins::Constants::Common

              # Checking accounts
              CHECKING = 'C'

              # Savings accounts
              SAVINGS  = 'S'

              # Maestra accounts(Only Peru)
              MAESTRA  = 'M'

              # Payment accounts
              PAYMENT  = 'P'

            end
          end
        end
      end
    end
  end
end
