module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Threeds
            module Version2
              module CardHolderAccount
                # Threeds Version2 Card Holder Account Password Change Indicators
                class PasswordChangeIndicators

                  extend Mixins::Constants::Common

                  #  No change
                  NO_CHANGE          = 'no_change'.freeze

                  #  During Transaction
                  DURING_TRANSACTION = 'during_transaction'.freeze

                  #  Less than 30 days
                  LESS_THAN_30DAYS   = 'less_than_30days'.freeze

                  #  From 30 to 60 days
                  FROM_30_TO_60_DAYS = '30_to_60_days'.freeze

                  #  More than 60 days
                  MORE_THAN_60DAYS   = 'more_than_60days'.freeze

                end
              end
            end
          end
        end
      end
    end
  end
end
