# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Recurring
            # Recurring Types
            class Types

              extend Mixins::Constants::Common

              # Indication for an Initial Recurring Transaction. Respond to Init_Recurring
              INITIAL    = 'initial'

              # Indication for a Managed Recurring Transaction. Respond to Managed Recurring transactions.
              MANAGED    = 'managed'

              # Indication for a Subsequent Transaction on the Initial Recurring.
              # Respond to subsequent Recurring payments.
              SUBSEQUENT = 'subsequent'

            end
          end
        end
      end
    end
  end
end
