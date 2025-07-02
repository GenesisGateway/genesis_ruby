# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Data used by the document verification service to check
            # the authenticity of identity documents submitted by customers
            module VerificationDocumentAttributes

              attr_accessor :document_first_name, :document_last_name
              attr_reader   :document_allow_offline, :document_allow_online

              # Customer's date of birth
              def document_date_of_birth
                @document_date_of_birth&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                )
              end

              # Customer's date of birth
              def document_date_of_birth=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Whether uploading of previously taken picture is allowed for verification of document
              def document_allow_offline=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Whether the realtime usage of device camera is allowed for verification of document
              def document_allow_online=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              protected

              # Defines the structure of the document attributes
              def verification_document_attributes_structure
                {
                  first_name:    document_first_name,
                  last_name:     document_last_name,
                  date_of_birth: document_date_of_birth,
                  allow_offline: document_allow_offline,
                  allow_online:  document_allow_online
                }
              end

            end
          end
        end
      end
    end
  end
end
