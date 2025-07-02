# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Threeds
            module Version2
              module MerchantRisk
                # Threeds Version2 Merchant Risk Re-Order Item Indicators
                class ReorderItemIndicators

                  extend Mixins::Constants::Common

                  # First Time
                  FIRST_TIME = 'first_time'

                  # Reordered
                  REORDERED  = 'reordered'

                end
              end
            end
          end
        end
      end
    end
  end
end
