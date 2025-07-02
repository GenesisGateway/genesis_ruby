# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # SCA Exemptions
          class ScaExemptions

            extend Mixins::Constants::Common

            # Exemption Low Value
            LOW_VALUE                = 'low_value'

            # Exemption Low Risk
            LOW_RISK                 = 'low_risk'

            # Exemption Trusted Merchant
            TRUSTED_MERCHANT         = 'trusted_merchant'

            # Exemption Corporate Payment
            CORPORATE_PAYMENT        = 'corporate_payment'

            # Exemption Delegated Authentication
            DELEGATED_AUTHENTICATION = 'delegated_authentication'

            # Exemption Auth Network Outage
            AUTH_NETWORK_OUTAGE      = 'auth_network_outage'

          end
        end
      end
    end
  end
end
