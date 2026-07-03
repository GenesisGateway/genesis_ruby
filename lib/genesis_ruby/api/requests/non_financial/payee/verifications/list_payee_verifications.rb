# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          module Verifications
            # Retrieve the details of all Verification records that belongs to specific Payee.
            class ListPayeeVerifications < Base::NonFinancial::Payee::Base

              attr_accessor :payee_unique_id

              # List Payee Verifications initialization
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'payee/:payee_unique_id/verifications'
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
