# frozen_string_literal: true

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
              INITIAL      = 'initial'

              # Payment Type SUBSEQUENT
              SUBSEQUENT   = 'subsequent'

              # Payment Type MODIFICATION
              MODIFICATION = 'modification'

              # Payment Type CANCELLATION
              CANCELLATION = 'cancellation'

            end
          end
        end
      end
    end
  end
end
