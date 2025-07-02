# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            # SCA Exemption Values
            class ScaExemptions

              extend Mixins::Constants::Common

              LOW_VALUE                = 'low_value'
              LOW_RISK                 = 'low_risk'
              TRUSTED_MERCHANT         = 'trusted_merchant'
              CORPORATE_PAYMENT        = 'corporate_payment'
              DELEGATED_AUTHENTICATION = 'delegated_authentication'
              AUTH_NETWORK_OUTAGE      = 'auth_network_outage'

            end
          end
        end
      end
    end
  end
end
