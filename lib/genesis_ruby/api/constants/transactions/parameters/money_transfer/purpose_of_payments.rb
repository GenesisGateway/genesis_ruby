# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module MoneyTransfer
            # Money Transfer Purpose of Payments
            class PurposeOfPayments

              extend Mixins::Constants::Common

              # Family support
              FAMILY_SUPPORT      = 'family_support'

              # Education
              EDUCATION           = 'education'

              # Gift and donation
              GIFT_AND_DONATION   = 'gift_and_donation'

              # Medical treatment
              MEDICAL_TREATMENT   = 'medical_treatment'

              # Maintenance expenses
              MAINTENANCE         = 'maintenance'

              # Travel
              TRAVEL              = 'travel'

              # Small value remittance
              SMALL_VALUE         = 'small_value'

              # Liberalized remittance
              LIBERALIZED         = 'liberalized'

              # Savings/Investments
              SAVINGS_INVESTMENTS = 'savings_investments'

              # Other
              OTHER               = 'other'

            end
          end
        end
      end
    end
  end
end
