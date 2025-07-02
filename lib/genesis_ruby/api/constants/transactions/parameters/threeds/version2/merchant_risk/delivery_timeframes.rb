# frozen_string_literal: true

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
                  ELECTRONICS = 'electronic'

                  # Same Day
                  SAME_DAY    = 'same_day'

                  # Over Night
                  OVER_NIGHT  = 'over_night'

                  # Another Day
                  ANOTHER_DAY = 'another_day'

                end
              end
            end
          end
        end
      end
    end
  end
end
