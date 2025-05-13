module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # Names of supported African Mobile network operators
          class AfricanMobileOperators

            extend Mixins::Constants::Common

            AIRTEL    = 'AIRTEL'.freeze

            MOVITEL   = 'MOVITEL'.freeze

            MTN       = 'MTN'.freeze

            SAFARICOM = 'SAFARICOM'.freeze

            TIGO      = 'TIGO'.freeze

            VODACOM   = 'VODACOM'.freeze

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
