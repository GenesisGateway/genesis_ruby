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
                  GOODS              = 'goods'.freeze

                  # Service
                  SERVICE            = 'service'.freeze

                  # Acceptance check
                  CHECK_ACCEPTANCE   = 'check_acceptance'.freeze

                  # Funding account
                  ACCOUNT_FUNDING    = 'account_funding'.freeze

                  # Cash quasi
                  QUASI_CASH         = 'quasi_cash'.freeze

                  # Prepaid activation
                  PREPAID_ACTIVATION = 'prepaid_activation'.freeze

                  # Load
                  LOAN               = 'loan'.freeze

                end
              end
            end
          end
        end
      end
    end
  end
end
