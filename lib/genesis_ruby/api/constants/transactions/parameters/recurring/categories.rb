module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Recurring
            # Recurring Categories
            class Categories

              extend Mixins::Constants::Common

              # Recurring Category Subscription - fixed amount, fixed intervals
              SUBSCRIPTION   = 'subscription'.freeze

              # Recurring Category Standing Order - varying amount, fixed intervals
              STANDING_ORDER = 'standing_order'.freeze

            end
          end
        end
      end
    end
  end
end
