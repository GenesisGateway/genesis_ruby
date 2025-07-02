# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # Names of supported African Mobile network operators
          class AfricanMobileOperators

            extend Mixins::Constants::Common

            AIRTEL    = 'AIRTEL'

            MOVITEL   = 'MOVITEL'

            MTN       = 'MTN'

            SAFARICOM = 'SAFARICOM'

            TIGO      = 'TIGO'

            VODACOM   = 'VODACOM'

            class << self

              # Return African Mobile Sale operators
              def sale
                %w(VODACOM SAFARICOM AIRTEL MTN)
              end

            end

          end
        end
      end
    end
  end
end
