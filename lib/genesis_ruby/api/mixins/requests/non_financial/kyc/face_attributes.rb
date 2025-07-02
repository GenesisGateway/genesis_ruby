# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/document_supported_types'
require 'genesis_ruby/utils/country'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Represents the options to be supplied to the service in order to provide face verification functionality
            module FaceAttributes

              attr_reader :face_allow_offline, :face_allow_online, :face_check_duplicate_request

              # Whether uploading of previously taken picture is allowed for verification of face
              def face_allow_offline=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Whether the realtime usage of device camera is allowed for verification of face
              def face_allow_online=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              # Whether to enable the duplicate account detection service
              def face_check_duplicate_request=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              protected

              # Defines the structure of the face attributes
              def face_attributes_structure
                {
                  allow_offline:           face_allow_offline,
                  allow_online:            face_allow_online,
                  check_duplicate_request: face_check_duplicate_request
                }
              end

            end
          end
        end
      end
    end
  end
end
