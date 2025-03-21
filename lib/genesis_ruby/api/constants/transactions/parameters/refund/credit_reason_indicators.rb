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
              INDICATOR_A = 'A'.freeze

              # Travel Ticket and Passenger Transport
              INDICATOR_B = 'B'.freeze

              # Partial Refund of Travel Ticket
              INDICATOR_P = 'P'.freeze

              # Other
              INDICATOR_O = 'O'.freeze

            end
          end
        end
      end
    end
  end
end
