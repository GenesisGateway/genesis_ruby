# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Refund
            # Credit Reason Indicator allowed values
            class CreditReasonIndicators

              extend Api::Mixins::Constants::Common

              # Passenger Transport Ancillary Cancellation
              INDICATOR_A = 'A'

              # Travel Ticket and Passenger Transport
              INDICATOR_B = 'B'

              # Partial Refund of Travel Ticket
              INDICATOR_P = 'P'

              # Other
              INDICATOR_O = 'O'

            end
          end
        end
      end
    end
  end
end
