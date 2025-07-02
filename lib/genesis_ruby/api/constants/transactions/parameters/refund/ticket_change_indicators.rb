# frozen_string_literal: true

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
              INDICATOR_C = 'C'

              # New ticket
              INDICATOR_N = 'N'

            end
          end
        end
      end
    end
  end
end
