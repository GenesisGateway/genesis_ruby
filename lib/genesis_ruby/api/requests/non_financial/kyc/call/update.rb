# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/verification_statuses'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Call
            # Update Call Request class for KYC Non-Financial API services
            # This method is used to update the call status with the latest info received from the main system.
            # It also updates the transaction associated with this verification call.
            class Update < Api::Requests::Base::NonFinancial::Kyc::Base

              attr_accessor :reference_id, :security_code_input
              attr_writer   :verification_status

              # Initialize the Update Call document request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'update_authentication'
              end

              def verification_status
                @verification_status.to_s
              end

              protected

              # Initialize the field validations for the Update Call request
              def init_field_validations
                super

                required_fields.push *%i[
                  reference_id
                  security_code_input
                  verification_status
                ]

                field_values.merge! verification_status: Constants::NonFinancial::Kyc::VerificationStatuses.all
              end

              # Build the request structure for the Update Call request
              def request_structure
                {
                  reference_id:        reference_id,
                  security_code_input: security_code_input,
                  verification_status: verification_status
                }
              end

            end
          end
        end
      end
    end
  end
end
