# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module ManagedRecurring
            # Amount Type of the current recurring transaction. Values: fixed, max
            class AmountTypes

              extend Mixins::Constants::Common

              # Amount Type FIXED
              FIXED = 'fixed'

              # Amount Type MAX
              MAX   = 'max'

            end
          end
        end
      end
    end
  end
end
