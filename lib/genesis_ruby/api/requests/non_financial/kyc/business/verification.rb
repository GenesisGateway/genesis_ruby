# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Business
            # Performs verification of a specific Business record based on its ID
            class Verification < Api::Requests::Base::NonFinancial::Kyc::Base

              attr_accessor :business_id

              # Initializes the Business Verification Request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'businesses/:business_id/verification'
              end

              protected

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[business_id]
              end

              # Business Verification request structure
              def request_structure
                {}
              end

              # Override API endpoint with provided business ID
              def process_request_parameters
                super

                processed_path = request_path.gsub(':business_id', business_id.to_s)

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
