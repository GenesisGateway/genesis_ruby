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
              CHECKING = 'C'.freeze

              # Savings accounts
              SAVINGS  = 'S'.freeze

              # Maestra accounts(Only Peru)
              MAESTRA  = 'M'.freeze

              # Payment accounts
              PAYMENT  = 'P'.freeze

            end
          end
        end
      end
    end
  end
end
