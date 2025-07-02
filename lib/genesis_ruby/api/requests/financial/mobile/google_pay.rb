# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/mobile/google_pay/payment_subtypes'

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Mobile
          # Google Pay transaction request
          class GooglePay < Requests::Base::Financial

            attr_accessor :payment_subtype

            include Mixins::Requests::AddressInfoAttributes
            include Mixins::Requests::BirthDateAttributes
            include Mixins::Requests::DocumentAttributes
            include Mixins::Requests::Financial::AsyncAttributes
            include Mixins::Requests::Financial::Business::BusinessAttributes
            include Mixins::Requests::Financial::Cards::Recurring::RecurringTypeAttributes
            include Mixins::Requests::Financial::DynamicDescriptorAttributes
            include Mixins::Requests::Financial::FundingAttributes
            include Mixins::Requests::Financial::Mobile::GooglePayTokenAttributes
            include Mixins::Requests::Financial::NotificationAttributes
            include Mixins::Requests::Financial::Threeds::Version2::CommonAttributes

            # Define a payment token from a JSON string
            def json_token=(value)
              json_object = Utils::Common.parse_json_string value

              map_google_pay_token_attributes json_object
            end

            protected

            # Google Pay transaction request type
            def transaction_type
              Constants::Transactions::GOOGLE_PAY
            end

            # Google Pay Required fields
            def init_field_validations
              super

              required_fields.push *%i[transaction_id payment_subtype amount currency token_signature token_signed_key
                token_signatures token_protocol_version token_signed_message]

              field_values.merge! payment_subtype: Constants::Transactions::Parameters::Mobile::GooglePay::
                                      PaymentSubtypes.all,
                                  recurring_type:  [Api::Constants::Transactions::Parameters::Recurring::Types::INITIAL]
              field_values.merge! threeds_field_validations, funding_attributes_field_validations

              field_value_dependencies.merge! threeds_field_conditional_validations
            end

            # Special validations upon document building
            def check_requirements
              validate_threeds_card_holder_dates

              super
            end

            # Google Pay Payment Transaction Structure
            def payment_transaction_structure # rubocop:disable Metrics/MethodLength
              {
                payment_subtype:           payment_subtype,
                payment_token:             google_pay_token_structure,
                customer_email:            customer_email,
                customer_phone:            customer_phone,
                birth_date:                birth_date,
                notification_url:          notification_url,
                return_success_url:        return_success_url,
                return_failure_url:        return_failure_url,
                billing_address:           billing_address_parameters_structure,
                shipping_address:          shipping_address_parameters_structure,
                business_attributes:       business_attributes_structure,
                dynamic_descriptor_params: dynamic_descriptor_structure,
                document_id:               document_id,
                recurring_type:            recurring_type,
                threeds_v2_params:         threeds_v2_common_attributes_structure,
                funding:                   funding_attributes_structure
              }
            end

            private

            # Map the Google Pay Token attributes from the given Hash object
            def map_google_pay_token_attributes(json_object)
              return nil unless json_object.is_a? Hash

              json_object.each do |token_key, token_value|
                if token_value.is_a? Hash
                  map_google_pay_token_attributes token_value

                  next
                end

                token_method = "token_#{GenesisRuby::Utils::Common.camel_to_snake_case(token_key)}="

                __send__ token_method, token_value if respond_to? token_method
              end

              nil
            end

          end
        end
      end
    end
  end
end
