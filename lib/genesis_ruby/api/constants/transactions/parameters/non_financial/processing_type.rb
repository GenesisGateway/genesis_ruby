module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            # Filter requests by being card present or card not present
            class ProcessingType

              extend Mixins::Constants::Common

              CARD_PRESENT     = 'card_present'.freeze
              CARD_NOT_PRESENT = 'card_not_present'.freeze
              ALL              = 'all'.freeze

            end
          end
        end
      end
    end
  end
end
