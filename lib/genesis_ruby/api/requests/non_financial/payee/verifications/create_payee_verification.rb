# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          module Verifications
            # Create a Verification for a specific Payee.
            class CreatePayeeVerification < Base::NonFinancial::Payee::Base

              attr_accessor :payee_unique_id, :notification_url, :redirect_url, :with_checks_retry

              # Create Payee Verification initialization
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'payee/:payee_unique_id/verifications'
              end

              protected

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[
                  payee_unique_id
                ]
              end

              # Returns the request structure
              def request_structure
                {
                  verification: {
                    notification_url:  notification_url,
                    redirect_url:      redirect_url,
                    with_checks_retry: with_checks_retry
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
end
