# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/identity_document_methods'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module IdentityDocument
            # Used to verify documents provided by the customer.
            class Upload < Api::Requests::Base::NonFinancial::Kyc::Base

              include Api::Mixins::Requests::NonFinancial::Kyc::IdentityDocumentAttributes

              attr_accessor :customer_username, :customer_unique_id, :transaction_unique_id, :reference_id, :method

              # Initialize the Upload Document request
              def initialize(configuration, _builder_interface = nil)
                super(configuration)

                self.request_path = 'upload_document'
              end

              protected

              # Initializes the required fields for the Upload Document request
              def init_field_validations
                super

                required_fields.push *%i[
                  method
                ]

                field_values.merge! method: GenesisRuby::Api::Constants::NonFinancial::Kyc::IdentityDocumentMethods.all
              end

              # Validates the request parameters
              def check_requirements
                raise ParameterError, 'Either transaction_unique_id or reference_id field has to be set.' if transaction_unique_id.nil? && reference_id.nil? # rubocop:disable Layout/LineLength
                raise ParameterError, 'Add at least one document' if docs.empty?

                super
              end

              # Returns the request structure for the Upload Document request
              def request_structure # rubocop:disable Metrics/MethodLength
                {
                  customer_username:     customer_username,
                  customer_unique_id:    customer_unique_id,
                  transaction_unique_id: transaction_unique_id,
                  reference_id:          reference_id,
                  method:                method,
                  doc:                   get_doc(0),
                  doc2:                  get_doc(1),
                  doc3:                  get_doc(2),
                  doc4:                  get_doc(3)
                }
              end

            end
          end
        end
      end
    end
  end
end
