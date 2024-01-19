module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module ManagedRecurring
            # Modes indicates whether merchant will manage manual or automatic recurring transactions
            class Modes

              extend Mixins::Constants::Common

              # Mode AUTOMATIC
              AUTOMATIC = 'automatic'.freeze

              # Mode MANUAL
              MANUAL    = 'manual'.freeze

            end
          end
        end
      end
    end
  end
end
