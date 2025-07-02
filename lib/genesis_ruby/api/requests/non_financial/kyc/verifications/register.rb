# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Verifications
            # Verification register request can be performed by reference_id. A reference id registration
            # allows you to store the reference id in Genesis and receive notifications in Genesis for it.
            class Register < Api::Requests::Base::NonFinancial::Kyc::Base

              include Api::Mixins::Requests::Financial::ReferenceAttributes

              # Initialize the request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'verifications/register'
              end

              protected

              # Set the request field validations
              def init_field_validations
                super

                required_fields.push *%i[reference_id]
              end

              # Return request structure
              def request_structure
                {
                  reference_id: reference_id
                }
              end

            end
          end
        end
      end
    end
  end
end
