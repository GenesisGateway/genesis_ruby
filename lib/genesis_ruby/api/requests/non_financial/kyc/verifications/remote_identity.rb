require 'genesis_ruby/api/constants/non_financial/kyc/document_supported_types'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Verifications
            # Remote Identity Verification Request class for KYC Non-Financial API services
            class RemoteIdentity < Api::Requests::Base::NonFinancial::Kyc::Base

              include Api::Mixins::Requests::NonFinancial::Kyc::DocumentAttributes

              # Initializes the Remote Identity Verification Request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'verifications'
              end

              attr_accessor :reference_id, :country, :backside_proof_required
              attr_reader   :email

              # Sets the email address for the Remote Identity verification
              def email=(value)
                raise InvalidArgumentError unless value =~ /\A.+@.+\..+\Z/

                @email = value
              end

              # Gets the expiry date for the Remote Identity verification
              def expiry_date
                @expiry_date&.strftime(
                  Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                )
              end

              # Sets the expiry date for the Remote Identity verification
              def expiry_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Sets the document supported types for the Remote Identity verification
              def document_supported_types=(value)
                parse_array_of_strings attribute: __method__,
                                       value: value,
                                       allowed: Api::Constants::NonFinancial::Kyc::DocumentSupportedTypes.all
              end

              # Returns the document supported types for the Remote Identity verification
              def document_supported_types
                @document_supported_types || []
              end

              # Initializes field validations for the Remote Identity verification request
              def init_field_validations
                super

                field_values.merge! country: GenesisRuby::Utils::Country::COUNTRIES.keys.map(&:upcase),
                                    backside_proof_required: [true, false]
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
