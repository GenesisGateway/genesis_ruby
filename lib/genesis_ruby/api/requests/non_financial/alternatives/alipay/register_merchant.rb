# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/alternatives/alipay/merchant_types'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Alternatives
          module Alipay
            # Registers an online-payment merchant in Alipay or updates an existing registration
            class RegisterMerchant < Api::Requests::Base::Versioned

              include Api::Mixins::Requests::NonFinancial::Alternatives::Alipay::SiteInformationAttributes

              PHONE_PATTERN        = /\A[0-9+\-()]+\z/.freeze
              ALPHANUMERIC_PATTERN = /\A[a-zA-Z0-9]+\z/.freeze
              EMAIL_PATTERN        = /\A.+@.+\..+\z/.freeze
              private_constant :PHONE_PATTERN, :ALPHANUMERIC_PATTERN, :EMAIL_PATTERN

              attr_accessor :merchant_type
              attr_reader :shareholder_id, :shareholder_name, :registration_number, :representative_name,
                          :representative_id, :settlement_number, :contact_number, :contact_email,
                          :customer_service_number, :customer_service_email

              # Register Merchant constructor
              def initialize(configuration, _builder_interface = nil)
                super configuration, Builder::JSON

                self.request_path = 'alipay/register_merchant'
              end

              # Shareholder ID, max 128 characters
              def shareholder_id=(value)
                restricted_string attribute: __method__, value: value, max: 128
              end

              # Shareholder name, max 64 characters
              def shareholder_name=(value)
                restricted_string attribute: __method__, value: value, max: 64
              end

              # Business registration number, max 128 characters
              def registration_number=(value)
                restricted_string attribute: __method__, value: value, max: 128
              end

              # Legal representative name, max 64 characters
              def representative_name=(value)
                restricted_string attribute: __method__, value: value, max: 64
              end

              # Legal representative ID, max 128 characters
              def representative_id=(value)
                restricted_string attribute: __method__, value: value, max: 128
              end

              # Settlement number, letters and digits only, max 64 characters
              def settlement_number=(value)
                restricted_string attribute: __method__, value: value, max: 64, pattern: ALPHANUMERIC_PATTERN
              end

              # Contact phone number, digits and + - ( ), max 64 characters
              def contact_number=(value)
                restricted_string attribute: __method__, value: value, max: 64, pattern: PHONE_PATTERN
              end

              # Contact email address, max 128 characters
              def contact_email=(value)
                restricted_string attribute: __method__, value: value, max: 128, pattern: EMAIL_PATTERN
              end

              # Customer service phone number, digits and + - ( ), max 64 characters
              def customer_service_number=(value)
                restricted_string attribute: __method__, value: value, max: 64, pattern: PHONE_PATTERN
              end

              # Customer service email address, max 128 characters
              def customer_service_email=(value)
                restricted_string attribute: __method__, value: value, max: 128, pattern: EMAIL_PATTERN
              end

              protected

              # Append the terminal token to the versioned gateway URL
              def init_configuration
                super

                init_api_gateway_configuration request_path: "#{version}/#{request_path}", include_token: true
              end

              # Register Merchant field validations
              def init_field_validations
                super

                merchant_types = Constants::NonFinancial::Alternatives::Alipay::MerchantTypes

                required_fields.push *%i[merchant_type site_information_type site_information_url contact_number]

                field_values.merge! merchant_type: merchant_types.all
                field_values.merge! site_information_field_validations

                field_value_dependencies.merge! merchant_type: {
                  merchant_types::ENTERPRISE => %i[shareholder_id shareholder_name registration_number],
                  merchant_types::INDIVIDUAL => %i[representative_name representative_id]
                }
              end

              # Register Merchant request structure
              def request_structure # rubocop:disable Metrics/MethodLength
                {
                  merchant_type:           merchant_type,
                  site_information:        site_information_structure,
                  shareholder_id:          shareholder_id,
                  shareholder_name:        shareholder_name,
                  registration_number:     registration_number,
                  representative_name:     representative_name,
                  representative_id:       representative_id,
                  settlement_number:       settlement_number,
                  contact_number:          contact_number,
                  contact_email:           contact_email,
                  customer_service_number: customer_service_number,
                  customer_service_email:  customer_service_email
                }
              end

              private

              # Store nil for empty input, otherwise validate the format first and the length last,
              # so that a failed assignment keeps the previous value
              def restricted_string(attribute:, value:, max:, pattern: nil)
                return assign_instance_variable attribute, nil if value.to_s.empty?

                if pattern && !pattern.match?(value.to_s)
                  raise InvalidArgumentError, "Invalid value for #{attribute.to_s.chomp("=")}! Invalid format."
                end

                limited_string attribute: attribute, value: value.to_s, max: max
              end

            end
          end
        end
      end
    end
  end
end
