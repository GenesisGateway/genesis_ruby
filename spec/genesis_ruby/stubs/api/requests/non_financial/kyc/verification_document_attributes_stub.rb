# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Kyc
            # Stub class for VerificationDocumentAttributes mixin
            class VerificationDocumentAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::VerificationDocumentAttributes

              public :verification_document_attributes_structure

            end
          end
        end
      end
    end
  end
end
