# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          # Create a Payee record.
          class Create < Base::Versioned

            PAYEE_TYPE_PERSON  = 'person'
            PAYEE_TYPE_COMPANY = 'company'

            attr_accessor :payee_type, :payee_name, :payee_country, :payee_notification_url,
                          :payee_registration_number, :payee_address_city, :payee_address_street,
                          :payee_address_state, :payee_address_country, :payee_address_zip_code

            # Payee date getter formatted as YYYY-MM-DD
            def payee_date
              @payee_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
            end

            # Payee date setter with date validation
            def payee_date=(value)
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            # Create Payee initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'payee'
            end

            protected

            # Sets the request field validations
            def init_field_validations
              super

              required_fields.push *%i[
                payee_type payee_name payee_country
              ]

              field_values.merge! payee_type:            [PAYEE_TYPE_PERSON, PAYEE_TYPE_COMPANY],
                                  payee_country:         GenesisRuby::Utils::Country::COUNTRIES.keys,
                                  payee_address_country: GenesisRuby::Utils::Country::COUNTRIES.keys
            end

            # Returns the request structure
            def request_structure # rubocop:disable Metrics/MethodLength
              {
                payee: {
                  type:                payee_type,
                  name:                payee_name,
                  country:             payee_country,
                  date:                payee_date,
                  notification_url:    payee_notification_url,
                  registration_number: payee_registration_number,
                  address:             payee_address_structure
                }
              }
            end

            # Override API endpoint configuration
            def process_request_parameters
              super

              init_api_service_configuration request_path: request_path, include_token: false
            end

            private

            # Build the nested address structure
            def payee_address_structure
              {
                city:     payee_address_city,
                street:   payee_address_street,
                state:    payee_address_state,
                country:  payee_address_country,
                zip_code: payee_address_zip_code
              }
            end

          end
        end
      end
    end
  end
end
