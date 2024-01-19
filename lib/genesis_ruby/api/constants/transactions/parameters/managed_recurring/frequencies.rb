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
              DAILY            = 'daily'.freeze

              # Frequency TWICE_WEEKLY
              TWICE_WEEKLY     = 'twice_weekly'.freeze

              # Frequency WEEKLY
              WEEKLY           = 'weekly'.freeze

              # Frequency TEN DAYS
              TEN_DAYS         = 'ten_days'.freeze

              # Frequency FORTNIGHTLY
              FORTNIGHTLY      = 'fortnightly'.freeze

              # Frequency MONTHLY
              MONTHLY          = 'monthly'.freeze

              # Frequency EVERY TWO MONTHS
              EVERY_TWO_MONTHS = 'every_two_months'.freeze

              # Frequency TRIMESTER
              TRIMESTER        = 'trimester'.freeze

              # Frequency QUARTERLY
              QUARTERLY        = 'quarterly'.freeze

              # Frequency TWICE YEARLY
              TWICE_YEARLY     = 'twice_yearly'.freeze

              # Frequency ANNUALLY
              ANNUALLY         = 'annually'.freeze

              # Frequency UNSCHEDULED
              UNSCHEDULED      = 'unscheduled'.freeze

            end
          end
        end
      end
    end
  end
end
