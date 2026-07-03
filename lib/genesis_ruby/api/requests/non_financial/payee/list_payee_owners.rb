# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          # Retrieve the details of all Owner records that belongs to specific Payee.
          class ListPayeeOwners < Base::NonFinancial::Payee::Base

            attr_accessor :payee_unique_id, :type

            # List Payee Owners initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'payee/:payee_unique_id/owners'
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
              processed_path = request_path.dup.gsub(':payee_unique_id', payee_unique_id.to_s)

              query_params = build_query_params
              processed_path += "?#{query_params}" unless query_params.empty?

              init_api_service_configuration request_path: processed_path, include_token: false

              super
            end

            private

            # Build query parameters from filter fields
            def build_query_params
              params = {}
              params['type'] = type if type

              URI.encode_www_form(params)
            end

          end
        end
      end
    end
  end
end
