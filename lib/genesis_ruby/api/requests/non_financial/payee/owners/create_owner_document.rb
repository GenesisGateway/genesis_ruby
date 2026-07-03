# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/payee/document_types'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          module Owners
            # Create a Document for a specific Owner.
            class CreateOwnerDocument < Base::NonFinancial::Payee::Base

              attr_accessor :owner_unique_id, :document_type, :file

              # Create Owner Document initialization
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'payee/owners/:owner_unique_id/documents'
              end

              protected

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[
                  owner_unique_id
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

                processed_path = request_path.dup.gsub(':owner_unique_id', owner_unique_id.to_s)

                init_api_service_configuration request_path: processed_path, include_token: false
              end

            end
          end
        end
      end
    end
  end
end
