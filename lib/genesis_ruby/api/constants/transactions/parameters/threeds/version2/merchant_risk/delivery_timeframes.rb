module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Threeds
            module Version2
              module MerchantRisk
                # Threeds Version2 Merchant Risk Delivery Timeframes
                class DeliveryTimeframes

                  extend Mixins::Constants::Common

                  # Electronics
                  ELECTRONICS = 'electronic'.freeze

                  # Same Day
                  SAME_DAY    = 'same_day'.freeze

                  # Over Night
                  OVER_NIGHT  = 'over_night'.freeze

                  # Another Day
                  ANOTHER_DAY = 'another_day'.freeze

                end
              end
            end
          end
        end
      end
    end
  end
end
