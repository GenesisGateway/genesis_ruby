module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Refund
            # Ticket Change Indicator allowed values
            class TicketChangeIndicators

              extend Api::Mixins::Constants::Common

              # Change to existing Ticket
              INDICATOR_C = 'C'.freeze

              # New ticket
              INDICATOR_N = 'N'.freeze

            end
          end
        end
      end
    end
  end
end
