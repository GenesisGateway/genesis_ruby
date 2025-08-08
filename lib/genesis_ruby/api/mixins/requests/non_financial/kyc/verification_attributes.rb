# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/document_supported_types'
require 'genesis_ruby/utils/country'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Common Verification Attributes mixin
            module VerificationAttributes

              attr_accessor :reference_id
              attr_reader   :email, :backside_proof_required, :country

              # User's email
              def email=(value)
                parse_email attribute: __method__, value: value
              end

              # Signifies that both sides of the document are required to verify the identity
              def backside_proof_required=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Document's expiry date
              def expiry_date
                @expiry_date&.strftime(
                  Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                )
              end

              # Document's expiry date
              def expiry_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Supported types of document that can be verified
              def document_supported_types=(value)
                parse_array_of_strings attribute:   __method__,
                                       value:       value,
                                       allowed:     Api::Constants::NonFinancial::Kyc::DocumentSupportedTypes.all,
                                       allow_empty: true
              end

              # Supported types of document that can be verified
              def document_supported_types
                @document_supported_types || []
              end

              # Country code
              def country=(value)
                allowed_options attribute:     __method__,
                                allowed:       GenesisRuby::Utils::Country::COUNTRIES.keys,
                                value:         value,
                                error_message: 'Invalid country code',
                                allow_empty:   true
              end

            end
          end
        end
      end
    end
  end
end
