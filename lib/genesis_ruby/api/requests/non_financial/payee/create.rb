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

            attr_accessor :payee_type, :payee_name, :payee_country

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

              field_values.merge! payee_type:    [PAYEE_TYPE_PERSON, PAYEE_TYPE_COMPANY],
                                  payee_country: GenesisRuby::Utils::Country::COUNTRIES.keys
            end

            # Returns the request structure
            def request_structure
              {
                payee: {
                  type:    payee_type,
                  name:    payee_name,
                  country: payee_country
                }
              }
            end

            # Override API endpoint configuration
            def process_request_parameters
              super

              init_api_service_configuration request_path: request_path, include_token: false
            end

          end
        end
      end
    end
  end
end
