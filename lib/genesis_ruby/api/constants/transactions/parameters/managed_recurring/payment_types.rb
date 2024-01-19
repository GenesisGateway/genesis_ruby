module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module ManagedRecurring
            # Payment Type of the current recurring transaction. Values: initial, subsequent, modification, cancellation
            class PaymentTypes

              extend Mixins::Constants::Common

              # Payment Type INITIAL
              INITIAL      = 'initial'.freeze

              # Payment Type SUBSEQUENT
              SUBSEQUENT   = 'subsequent'.freeze

              # Payment Type MODIFICATION
              MODIFICATION = 'modification'.freeze

              # Payment Type CANCELLATION
              CANCELLATION = 'cancellation'.freeze

            end
          end
        end
      end
    end
  end
end
