# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            # Sort Direction constants
            class SortDirections

              extend Mixins::Constants::Common

              # Ascending sort
              ASCENDING_SORT  = 'asc'

              # Descending sort
              DESCENDING_SORT = 'desc'

            end
          end
        end
      end
    end
  end
end
