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
              attr_reader   :document_allow_offline, :document_allow_online, :document_with_enhanced_data,
                            :document_allow_fuzzy_match, :document_allow_decline_during_single_step,
                            :document_with_optical_character_recognition_form

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

              # Whether enhanced data extraction from the document is performed
              def document_with_enhanced_data=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Whether fuzzy match is performed
              def document_allow_fuzzy_match=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Whether the face step is rejected on incorrect face submission
              def document_allow_decline_during_single_step=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Whether the OCR form is shown in the verification form
              def document_with_optical_character_recognition_form=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              protected

              # Defines the structure of the document attributes
              def verification_document_attributes_structure # rubocop:disable Metrics/MethodLength
                {
                  first_name:                              document_first_name,
                  last_name:                               document_last_name,
                  date_of_birth:                           document_date_of_birth,
                  allow_offline:                           document_allow_offline,
                  allow_online:                            document_allow_online,
                  with_enhanced_data:                      document_with_enhanced_data,
                  allow_fuzzy_match:                       document_allow_fuzzy_match,
                  allow_decline_during_single_step:        document_allow_decline_during_single_step,
                  with_optical_character_recognition_form: document_with_optical_character_recognition_form
                }
              end

            end
          end
        end
      end
    end
  end
end
