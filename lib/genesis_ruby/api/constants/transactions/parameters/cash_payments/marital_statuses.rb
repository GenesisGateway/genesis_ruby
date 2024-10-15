module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module CashPayments
            # Marital Statuses allowed values
            class MaritalStatuses

              extend Api::Mixins::Constants::Common

              # Not Married
              NOT_MARRIED = 0

              # Married
              MARRIED = 1

              # Divorced
              DIVORCED = 2

              # Separate
              SEPARATE = 3

              # Widower
              WIDOWER = 4

              # Single
              SINGLE = 5

              # Other
              OTHER = 6

            end
          end
        end
      end
    end
  end
end
