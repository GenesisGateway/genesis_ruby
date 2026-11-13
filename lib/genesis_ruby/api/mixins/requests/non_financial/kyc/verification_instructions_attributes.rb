# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Parameters for additional restrictions of the document for verification
            module VerificationInstructionsAttributes

              attr_reader :verification_instructions_allow_paper_based, :verification_instructions_allow_photocopy,
                          :verification_instructions_allow_laminated, :verification_instructions_allow_screenshot,
                          :verification_instructions_allow_cropped, :verification_instructions_allow_scanned

              # Enables scanning of a paper based document for the verification
              def verification_instructions_allow_paper_based=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Enables scanning of a photocopy of a document for the verification
              def verification_instructions_allow_photocopy=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Enables scanning of a laminated document for the verification
              def verification_instructions_allow_laminated=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Enables scanning of a screenshot of a document for the verification
              def verification_instructions_allow_screenshot=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Enables scanning of a cropped document for the verification
              def verification_instructions_allow_cropped=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Enables scanning of a scanned document for the verification
              def verification_instructions_allow_scanned=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              protected

              # Defines the structure of the verification instructions attributes
              def verification_instructions_attributes_structure
                {
                  allow_paper_based: verification_instructions_allow_paper_based,
                  allow_photocopy:   verification_instructions_allow_photocopy,
                  allow_laminated:   verification_instructions_allow_laminated,
                  allow_screenshot:  verification_instructions_allow_screenshot,
                  allow_cropped:     verification_instructions_allow_cropped,
                  allow_scanned:     verification_instructions_allow_scanned
                }
              end

            end
          end
        end
      end
    end
  end
end
