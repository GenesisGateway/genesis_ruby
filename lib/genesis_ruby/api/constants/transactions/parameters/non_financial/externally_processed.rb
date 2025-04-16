module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            # Filter requests by being externally processed or being native to Genesis
            class ExternallyProcessed

              extend Mixins::Constants::Common

              GENESIS  = 'genesis'.freeze
              EXTERNAL = 'external'.freeze
              ALL      = 'all'.freeze

            end
          end
        end
      end
    end
  end
end
