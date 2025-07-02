# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Verifications
            # Remote Identity Verification Request class for KYC Non-Financial API services
            class RemoteIdentity < Api::Requests::Base::NonFinancial::Kyc::Base

              include Api::Mixins::Requests::NonFinancial::Kyc::DocumentAttributes
              include Api::Mixins::Requests::NonFinancial::Kyc::VerificationAttributes

              # Initializes the Remote Identity Verification Request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'verifications'
              end

              protected

              # Performs validation checks for the Remote Identity verification request
              def check_requirements
                raise ParameterError, 'Either email or reference_id field has to be set.' if email.nil? && reference_id.nil? # rubocop:disable Layout/LineLength

                super
              end

              # Returns request structure for the Remote Identity verification
              def request_structure
                {
                  email:                    email,
                  reference_id:             reference_id,
                  country:                  country,
                  backside_proof_required:  backside_proof_required,
                  expiry_date:              expiry_date,
                  document_supported_types: document_supported_types,
                  document:                 document_attributes_structure
                }
              end

            end
          end
        end
      end
    end
  end
end
