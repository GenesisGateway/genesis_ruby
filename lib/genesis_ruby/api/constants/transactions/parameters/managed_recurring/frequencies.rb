# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module ManagedRecurring
            # Frequencies of the Frequency of the subsequent transactions.
            # Values: daily, twice_weekly, weekly, ten_days, fortnightly, monthly, every_two_months, trimester,
            # quarterly, twice_yearly, annually, unscheduled
            class Frequencies

              extend Mixins::Constants::Common

              # Frequency DAILY
              DAILY            = 'daily'

              # Frequency TWICE_WEEKLY
              TWICE_WEEKLY     = 'twice_weekly'

              # Frequency WEEKLY
              WEEKLY           = 'weekly'

              # Frequency TEN DAYS
              TEN_DAYS         = 'ten_days'

              # Frequency FORTNIGHTLY
              FORTNIGHTLY      = 'fortnightly'

              # Frequency MONTHLY
              MONTHLY          = 'monthly'

              # Frequency EVERY TWO MONTHS
              EVERY_TWO_MONTHS = 'every_two_months'

              # Frequency TRIMESTER
              TRIMESTER        = 'trimester'

              # Frequency QUARTERLY
              QUARTERLY        = 'quarterly'

              # Frequency TWICE YEARLY
              TWICE_YEARLY     = 'twice_yearly'

              # Frequency ANNUALLY
              ANNUALLY         = 'annually'

              # Frequency UNSCHEDULED
              UNSCHEDULED      = 'unscheduled'

            end
          end
        end
      end
    end
  end
end
