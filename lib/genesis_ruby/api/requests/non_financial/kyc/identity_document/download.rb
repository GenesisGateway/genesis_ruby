# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module IdentityDocument
            # Uploaded documents will be stored by legal provisions and they can be requested for review.
            class Download < Api::Requests::Base::NonFinancial::Kyc::Base

              attr_accessor :identity_document_id

              # Initialize the Download document request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'download_document'
              end

              protected

              # Initializes the required fields for the Download Document request
              def init_field_validations
                super

                required_fields.push *%i[identity_document_id]
              end

              # Returns the request structure for the Download Document request
              def request_structure
                {
                  identity_document_id: identity_document_id
                }
              end

            end
          end
        end
      end
    end
  end
end
