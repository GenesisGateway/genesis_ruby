# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module MoneyTransfer
            # Money Transfer Types
            class Types

              extend Mixins::Constants::Common

              # Visa money transfer type
              VISA       = 'visa'

              # Mastercard money transfer type
              MASTERCARD = 'mastercard'

            end
          end
        end
      end
    end
  end
end
