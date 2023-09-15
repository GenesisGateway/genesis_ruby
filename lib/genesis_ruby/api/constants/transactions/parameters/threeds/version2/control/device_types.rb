module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Threeds
            module Version2
              module Control
                # Threeds Version2 Control Device Types
                class DeviceTypes

                  extend Mixins::Constants::Common

                  # Browser-based consumer interface. All the browser parameters are required.
                  BROWSER     = 'browser'.freeze

                  # Application
                  APPLICATION = 'application'.freeze

                end
              end
            end
          end
        end
      end
    end
  end
end
