module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Threeds
            module Version2
              module CardHolderAccount
                # Threeds Version2 Card Holder Account Registration Indicators
                class RegistrationIndicators

                  extend Mixins::Constants::Common

                  # Guest Checkout
                  GUEST_CHECKOUT      = 'guest_checkout'.freeze

                  # Current Transaction
                  CURRENT_TRANSACTION = 'current_transaction'.freeze

                  # Less than 30 days
                  LESS_THAN_30DAYS    = 'less_than_30days'.freeze

                  # From 30 to 60 days
                  FROM_30_TO_60_DAYS  = '30_to_60_days'.freeze

                  # More than 60 days
                  MORE_THAN_60DAYS    = 'more_than_60days'.freeze

                end
              end
            end
          end
        end
      end
    end
  end
end
