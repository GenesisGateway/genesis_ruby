# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module ManagedRecurring
            # The interval type for the period: days or months. The default value is days
            class Intervals

              extend Mixins::Constants::Common

              # Interval DAYS
              DAYS   = 'days'

              # Interval MONTHS
              MONTHS = 'months'

            end
          end
        end
      end
    end
  end
end
