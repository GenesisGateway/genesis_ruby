module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            # SCA Exemption Values
            class ScaExemptions

              extend Mixins::Constants::Common

              LOW_VALUE                = 'low_value'.freeze
              LOW_RISK                 = 'low_risk'.freeze
              TRUSTED_MERCHANT         = 'trusted_merchant'.freeze
              CORPORATE_PAYMENT        = 'corporate_payment'.freeze
              DELEGATED_AUTHENTICATION = 'delegated_authentication'.freeze
              AUTH_NETWORK_OUTAGE      = 'auth_network_outage'.freeze

            end
          end
        end
      end
    end
  end
end
