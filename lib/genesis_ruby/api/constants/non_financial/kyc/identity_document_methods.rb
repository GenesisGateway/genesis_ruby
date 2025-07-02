# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # IdentityDocumentMethods module defines constants for different methods of handling identity documents
          class IdentityDocumentMethods

            extend Mixins::Constants::Common

            # Manual
            MANUAL = 1

            # OCR document
            OCR = 2

            # Both types - Manual/OCR
            BOTH = 3

          end
        end
      end
    end
  end
end
