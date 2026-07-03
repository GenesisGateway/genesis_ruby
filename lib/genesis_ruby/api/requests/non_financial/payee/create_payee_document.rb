# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/payee/document_types'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          # Create a Document for a specific Payee.
          class CreatePayeeDocument < Base::NonFinancial::Payee::Base

            attr_accessor :payee_unique_id, :document_type, :file

            # Create Payee Document initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'payee/:payee_unique_id/documents'
            end

            protected

            # Sets the request field validations
            def init_field_validations
              super

              required_fields.push *%i[
                payee_unique_id
                                     document_type
                                     file
              ]

              field_values.merge! document_type: GenesisRuby::Api::Constants::NonFinancial::Payee::DocumentTypes.all
            end

            # Returns the request structure
            def request_structure
              {
                document: {
                  document_type: document_type,
                  file:          file
                }
              }
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
