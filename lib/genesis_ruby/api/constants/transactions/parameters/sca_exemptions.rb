module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # SCA Exemptions
          class ScaExemptions

            extend Mixins::Constants::Common

            # Exemption Low Value
            LOW_VALUE                = 'low_value'.freeze

            # Exemption Low Risk
            LOW_RISK                 = 'low_risk'.freeze

            # Exemption Trusted Merchant
            TRUSTED_MERCHANT         = 'trusted_merchant'.freeze

            # Exemption Corporate Payment
            CORPORATE_PAYMENT        = 'corporate_payment'.freeze

            # Exemption Delegated Authentication
            DELEGATED_AUTHENTICATION = 'delegated_authentication'.freeze

            # Exemption Auth Network Outage
            AUTH_NETWORK_OUTAGE      = 'auth_network_outage'.freeze

          end
        end
      end
    end
  end
end
