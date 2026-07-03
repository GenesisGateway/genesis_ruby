# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          module Owners
            # Retrieve the details of a specific Document for a specific Owner.
            class RetrieveOwnerDocument < Base::NonFinancial::Payee::Base

              attr_accessor :owner_unique_id, :document_unique_id

              # Retrieve Owner Document initialization
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'payee/owners/:owner_unique_id/documents/:document_unique_id'
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
                  owner_unique_id
                                       document_unique_id
                ]
              end

              # Returns the request structure
              def request_structure
                {}
              end

              # Override API endpoint configuration
              def process_request_parameters
                processed_path = request_path.dup
                                             .gsub(':owner_unique_id', owner_unique_id.to_s)
                                             .gsub(':document_unique_id', document_unique_id.to_s)

                init_api_service_configuration request_path: processed_path, include_token: false

                super
              end

            end
          end
        end
      end
    end
  end
end
