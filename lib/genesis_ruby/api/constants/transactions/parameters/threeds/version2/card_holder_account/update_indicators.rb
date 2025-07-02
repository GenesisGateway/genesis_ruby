# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Threeds
            module Version2
              module CardHolderAccount
                # Threeds Version2 Card Holder Update Indicators
                class UpdateIndicators

                  extend Mixins::Constants::Common

                  # Current Transaction
                  CURRENT_TRANSACTION = 'current_transaction'

                  # Less than 30 days
                  LESS_THAN_30DAYS    = 'less_than_30days'

                  # From 30 to 60 days
                  FROM_30_TO_60_DAYS  = '30_to_60_days'

                  # More than 60 days
                  MORE_THAN_60DAYS    = 'more_than_60days'

                end
              end
            end
          end
        end
      end
    end
  end
end
