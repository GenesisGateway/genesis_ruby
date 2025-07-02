# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Cpf
            # Check the status of a specific Brazilian personal's CPF number
            class Check < Api::Requests::Base::NonFinancial::Kyc::Base

              include Api::Mixins::Requests::DocumentAttributes

              # Initializes the CPF Check Request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'cpf/:document_id'
              end

              protected

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[document_id]
              end

              # CPF Check request structure
              def request_structure
                {}
              end

              # Override API endpoint with provided document ID
              def process_request_parameters
                super

                processed_path = request_path.gsub(':document_id', document_id.to_s)

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
