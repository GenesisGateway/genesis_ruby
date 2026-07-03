# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/address_document_supported_types'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module Verifications
            # Address Verification by Document Proof
            # Verification of customer address using a document.
            class AddressByDocumentProof < Api::Requests::Base::NonFinancial::Kyc::Base

              include Api::Mixins::Requests::NonFinancial::Kyc::DocumentAttributes

              attr_accessor :reference_id
              attr_reader :backside_proof_required, :with_enhanced_address_verification, :with_async_workflow

              # Supported types of document that can be verified for address verification
              def document_supported_types=(value)
                parse_array_of_strings attribute: __method__,
                                       value: value,
                                       allowed: Api::Constants::NonFinancial::Kyc::AddressDocumentSupportedTypes.all,
                                       allow_empty: true
              end

              # Supported types of document that can be verified for address verification
              def document_supported_types
                @document_supported_types || []
              end

              # Initializes the Address Verification by Document Proof Request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'verifications/address/by_proof'
              end

              # A flag to enable the enhanced address verification
              def with_enhanced_address_verification=(value)
                allowed_options attribute: __method__,
                                allowed: [true, false],
                                value: value,
                                allow_empty: true,
                                error_message: 'Accepts only boolean values'
              end

              # Signifies that both sides of the document are required to verify the address
              def backside_proof_required=(value)
                allowed_options attribute: __method__,
                                allowed: [true, false],
                                value: value,
                                allow_empty: true,
                                error_message: 'Accepts only boolean values'
              end

              # A flag that controls whether the request is sent synchronously or asynchronously
              def with_async_workflow=(value)
                allowed_options attribute: __method__,
                                allowed: [true, false],
                                value: value,
                                allow_empty: true,
                                error_message: 'Accepts only boolean values'
              end

              protected

              # Set the request field validations
              def init_field_validations
                required_fields.push *%i[reference_id document_supported_types full_address proof]
              end

              # Returns request structure for the Address Verification by Document Proof
              def request_structure
                {
                  reference_id:                       reference_id,
                  document_supported_types:           document_supported_types,
                  backside_proof_required:            backside_proof_required,
                  with_enhanced_address_verification: with_enhanced_address_verification,
                  with_async_workflow:                with_async_workflow,
                  document:                           document_attributes_structure
                }
              end

            end
          end
        end
      end
    end
  end
end
