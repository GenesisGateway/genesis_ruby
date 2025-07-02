# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/service_languages'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Call
            # Create Call Request class for KYC Non-Financial API services
            # This method is used to make a call or send an SMS to a given phone number.
            class Create < Api::Requests::Base::NonFinancial::Kyc::Base

              SERVICE_TYPE_SMS   = 1
              SERVICE_TYPE_VOICE = 2

              VALID_SERVICE_TYPES = [SERVICE_TYPE_SMS, SERVICE_TYPE_VOICE].freeze

              attr_accessor :customer_username, :customer_unique_id, :transaction_unique_id, :service_language,
                            :service_type
              attr_reader   :customer_phone_number, :security_code

              # Initialize the Make Call document request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'create_authentication'
              end

              # Set the customer username for the Make Call request
              def customer_phone_number=(value)
                error_message = format(
                  'Invalid value given for %{attribute}',
                  attribute: __method__
                )
                raise GenesisRuby::InvalidArgumentError, error_message unless value.nil? || value =~ /^\d+$/

                @customer_phone_number = value
              end

              # Set the service type for the Make Call request
              def security_code=(value)
                error_message = format(
                  'Invalid value given for %{attribute}',
                  attribute: __method__
                )
                raise GenesisRuby::InvalidArgumentError, error_message unless value.nil? || value =~ /^[1-9]\d{3}$/

                @security_code = value
              end

              protected

              # Initialize field validations for the Make Call request
              def init_field_validations
                super

                required_fields.push *%i[
                  transaction_unique_id
                  customer_phone_number
                  service_language
                  security_code
                  service_type
                ]

                field_values.merge! service_type:     VALID_SERVICE_TYPES,
                                    service_language: GenesisRuby::Api::Constants::NonFinancial::Kyc::ServiceLanguages.all # rubocop:disable Layout/LineLength
              end

              # Build the request structure for the Make Call request
              def request_structure
                {
                  customer_unique_id:    customer_unique_id,
                  customer_username:     customer_username,
                  transaction_unique_id: transaction_unique_id,
                  customer_phone_number: customer_phone_number,
                  service_language:      service_language,
                  security_code:         security_code,
                  service_type:          service_type
                }
              end

            end
          end
        end
      end
    end
  end
end
