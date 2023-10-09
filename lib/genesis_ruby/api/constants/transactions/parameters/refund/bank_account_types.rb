module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Refund
            # Available Bank Account Types used in the Refund transaction request
            class BankAccountTypes

              extend Mixins::Constants::Common

              # C: for Checking accounts
              CHECKING      = 'C'.freeze

              # S: for Savings accounts
              SAVINGS       = 'S'.freeze

              # I: for International accounts
              INTERNATIONAL = 'I'.freeze

            end
          end
        end
      end
    end
  end
end
