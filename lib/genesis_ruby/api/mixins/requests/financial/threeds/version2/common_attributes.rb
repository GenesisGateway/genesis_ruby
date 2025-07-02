# frozen_string_literal: true

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

                # Threeds Common Attribute Field Validation
                def threeds_field_validations
                  {}.merge threeds_control_field_validations, threeds_purchase_field_validations,
                           threeds_merchant_risk_field_validations, threeds_card_holder_field_validations,
                           threeds_browser_field_validations, threeds_sdk_field_validations
                end

                def threeds_field_conditional_validations # rubocop:disable Metrics/MethodLength
                  {
                    threeds_v2_control_device_type: Hash[
                      Api::Constants::Transactions::Parameters::Threeds::Version2::Control::DeviceTypes::BROWSER,
                      %i[threeds_v2_browser_accept_header threeds_v2_browser_java_enabled threeds_v2_browser_language
                        threeds_v2_browser_color_depth threeds_v2_browser_screen_height
                        threeds_v2_browser_screen_width threeds_v2_browser_time_zone_offset
                        threeds_v2_browser_user_agent],
                      Api::Constants::Transactions::Parameters::Threeds::Version2::Control::DeviceTypes::APPLICATION,
                      %i[threeds_v2_sdk_interface threeds_v2_sdk_ui_types threeds_v2_sdk_application_id
                        threeds_v2_sdk_encrypted_data threeds_v2_sdk_ephemeral_public_key_pair
                        threeds_v2_sdk_max_timeout threeds_v2_sdk_reference_number]
                    ]
                  }
                end

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
