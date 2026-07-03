# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Business
            # Get a specific document related to the business entity
            class Document < Api::Requests::Base::NonFinancial::Kyc::Base

              attr_accessor :business_id, :id

              # Initializes the Business Document Request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'businesses/:business_id/documents/:id'
              end

              protected

              # Override default KYC Network configuration for GET request
              def init_configuration
                super

                init_get_configuration
              end

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[business_id id]
              end

              # Business Document request structure
              def request_structure
                {}
              end

              # Override API endpoint with provided business ID and document ID
              def process_request_parameters
                super

                processed_path = request_path.gsub(':business_id', business_id.to_s)
                                             .gsub(':id', id.to_s)

                init_kyc_service_configuration(
                  request_path: "api/#{version}/#{processed_path}"
                )
              end

            end
          end
        end
      end
    end
  end
end
