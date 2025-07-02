# frozen_string_literal: true

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
              DEPOSIT = 'deposit'

              # Balance
              BALANCE = 'balance'

            end
          end
        end
      end
    end
  end
end
