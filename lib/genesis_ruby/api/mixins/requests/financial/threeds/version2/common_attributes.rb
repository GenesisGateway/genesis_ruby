require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/browser'
require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/card_holder_account'
require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/control'
require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/merchant_risk'
require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/method'
require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/purchase'
require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/recurring'
require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/sdk'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Threeds
            module Version2
              # Threeds Version 2 Common Attributes
              module CommonAttributes

                include Browser
                include CardHolderAccount
                include Control
                include MerchantRisk
                include Method
                include Purchase
                include Recurring
                include Sdk

                protected

                # Threeds V2 Web Payment Form Attributes
                def threeds_v2_common_attributes_structure
                  {
                    threeds_method:      method_attributes,
                    control:             control_attributes,
                    purchase:            purchase_attributes,
                    merchant_risk:       merchant_risk_attributes,
                    card_holder_account: card_holder_account_attributes,
                    recurring:           recurring_attributes,
                    browser:             browser_attributes,
                    sdk:                 sdk_attributes
                  }
                end

              end
            end
          end
        end
      end
    end
  end
end
