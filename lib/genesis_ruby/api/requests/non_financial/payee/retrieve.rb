# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          # Retrieve the details of a specific a Payee record based on it's unique ID.
          class Retrieve < Base::Versioned

            attr_accessor :payee_unique_id

            # Retrieve Payee initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'payee/:payee_unique_id'
            end

            protected

            # Override default Versioned Network configuration
            def init_configuration
              super

              init_get_configuration
            end

            # Sets the request field validations
            def init_field_validations
              super

              required_fields.push *%i[
                payee_unique_id
              ]
            end

            # Returns the request structure
            def request_structure
              {}
            end

            # Override API endpoint configuration
            def process_request_parameters
              super

              processed_path = request_path.dup.gsub(':payee_unique_id', payee_unique_id.to_s)

              init_api_service_configuration request_path: processed_path, include_token: false
            end

          end
        end
      end
    end
  end
end
