# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/address_supported_types'
require 'genesis_ruby/api/constants/non_financial/kyc/languages'
require 'genesis_ruby/api/constants/non_financial/kyc/verification_modes'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Verifications
            # The verification request will provide a link that will be used to redirect the customer.
            # The customer will provide the required documents and will be verified against them.
            # As a result, the user will be redirected back to merchant based on the provided redirect URL.
            class Create < Api::Requests::Base::NonFinancial::Kyc::Base

              include Api::Mixins::Requests::NonFinancial::Kyc::BackgroundChecksAttributes
              include Api::Mixins::Requests::NonFinancial::Kyc::FaceAttributes
              include Api::Mixins::Requests::NonFinancial::Kyc::VerificationAttributes
              include Api::Mixins::Requests::NonFinancial::Kyc::VerificationDocumentAttributes

              attr_accessor :language, :address_backside_proof_required, :allow_retry, :verification_mode
              attr_reader   :redirect_url, :address_supported_types

              # Initializes the Create Verification Request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'verifications'
              end

              # URL where the customer is sent to after completing the verification process
              def redirect_url=(value)
                unless GenesisRuby::Utils::Common.valid_url?(value)
                  raise ParameterError, "Invalid URL given for #{__method__}"
                end

                @redirect_url = value
              end

              # Supported types of address that can be verified
              def address_supported_types=(value)
                parse_array_of_strings attribute:   __method__,
                                       value:       value,
                                       allowed:     Api::Constants::NonFinancial::Kyc::AddressSupportedTypes.all,
                                       allow_empty: true
              end

              protected

              def init_field_validations
                required_fields.push *%i[email]

                field_values.merge!(
                  language:                        Api::Constants::NonFinancial::Kyc::Languages.all,
                  address_backside_proof_required: [true, false],
                  allow_retry:                     [true, false],
                  verification_mode:               Api::Constants::NonFinancial::Kyc::VerificationModes.all
                )
              end

              # Returns request structure for the Create verification
              def request_structure # rubocop:disable Metrics/MethodLength
                {
                  email:                           email,
                  country:                         country,
                  language:                        language,
                  redirect_url:                    redirect_url,
                  reference_id:                    reference_id,
                  document_supported_types:        document_supported_types,
                  address_supported_types:         address_supported_types,
                  face:                            face_attributes_structure,
                  backside_proof_required:         backside_proof_required,
                  address_backside_proof_required: address_backside_proof_required,
                  expiry_date:                     expiry_date,
                  allow_retry:                     allow_retry,
                  verification_mode:               verification_mode,
                  background_checks:               background_checks_attributes_structure,
                  document:                        verification_document_attributes_structure
                }
              end

            end
          end
        end
      end
    end
  end
end
