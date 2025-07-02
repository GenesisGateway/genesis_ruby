# frozen_string_literal: true

require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/recurring'
require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/purchase'
require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/merchant_risk'
require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/control'
require 'genesis_ruby/api/mixins/requests/financial/threeds/version2/card_holder_account'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Threeds
            module Version2
              # Threeds Version 2 WPF Attributes
              module WpfAttributes

                include Control
                include Purchase
                include Recurring
                include MerchantRisk
                include CardHolderAccount

                # WPF doesn't support Threeds V2 Device Type parameter
                def threeds_v2_control_device_type
                  raise NoMethodError, "#{__method__} isn't available for the Web Payment Form"
                end

                # WPF doesn't support Threeds V2 Device Type parameter
                def threeds_v2_control_device_type=(_value)
                  raise NoMethodError, "#{__method__} isn't available for the Web Payment Form"
                end

                protected

                # Threeds Common Attribute Field Validation
                def threeds_field_validations
                  control_validations = threeds_control_field_validations
                  control_validations.delete(:threeds_v2_control_device_type)

                  {}.merge control_validations, threeds_purchase_field_validations,
                           threeds_merchant_risk_field_validations, threeds_card_holder_field_validations
                end

                # Request Control Attributes structure available for the Web Payment Form
                def control_attributes
                  {
                    challenge_window_size: threeds_v2_control_challenge_window_size,
                    challenge_indicator:   threeds_v2_control_challenge_indicator
                  }
                end

                # Threeds V2 Web Payment Form Attributes
                def threeds_v2_wpf_attributes_structure
                  {
                    control:             control_attributes,
                    purchase:            purchase_attributes,
                    merchant_risk:       merchant_risk_attributes,
                    card_holder_account: card_holder_account_attributes,
                    recurring:           recurring_attributes
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
