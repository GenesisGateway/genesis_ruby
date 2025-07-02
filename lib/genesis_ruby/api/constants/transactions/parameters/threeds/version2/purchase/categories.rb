# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Threeds
            module Version2
              module Purchase
                # Threeds Version2 Purchase Categories
                class Categories

                  extend Mixins::Constants::Common

                  # Goods
                  GOODS              = 'goods'

                  # Service
                  SERVICE            = 'service'

                  # Acceptance check
                  CHECK_ACCEPTANCE   = 'check_acceptance'

                  # Funding account
                  ACCOUNT_FUNDING    = 'account_funding'

                  # Cash quasi
                  QUASI_CASH         = 'quasi_cash'

                  # Prepaid activation
                  PREPAID_ACTIVATION = 'prepaid_activation'

                  # Load
                  LOAN               = 'loan'

                end
              end
            end
          end
        end
      end
    end
  end
end
