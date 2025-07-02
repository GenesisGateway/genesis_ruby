# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            # Filter requests by being externally processed or being native to Genesis
            class ExternallyProcessed

              extend Mixins::Constants::Common

              GENESIS  = 'genesis'
              EXTERNAL = 'external'
              ALL      = 'all'

            end
          end
        end
      end
    end
  end
end
