# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          # Update Payee
          class Update < Base::Versioned

            attr_accessor :payee_unique_id, :payee_name, :payee_country, :payee_notification_url,
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

            # Retrieve Payee initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'payee/:payee_unique_id'

              init_patch_configuration
            end

            protected

            # Sets the request field validations
            def init_field_validations
              super

              required_fields.push *%i[
                payee_unique_id
              ]
              field_values.merge! payee_country:         GenesisRuby::Utils::Country::COUNTRIES.keys,
                                  payee_address_country: GenesisRuby::Utils::Country::COUNTRIES.keys
            end

            # Returns the request structure
            def request_structure
              {
                payee: {
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

              processed_path = request_path.dup.gsub(':payee_unique_id', payee_unique_id.to_s)

              init_api_service_configuration request_path: processed_path, include_token: false
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
