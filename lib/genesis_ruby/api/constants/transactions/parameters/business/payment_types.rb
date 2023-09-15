module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Business
            # Business Attributes Payment Types
            class PaymentTypes

              extend Mixins::Constants::Common

              # Deposit
              DEPOSIT = 'deposit'.freeze

              # Balance
              BALANCE = 'balance'.freeze

            end
          end
        end
      end
    end
  end
end
