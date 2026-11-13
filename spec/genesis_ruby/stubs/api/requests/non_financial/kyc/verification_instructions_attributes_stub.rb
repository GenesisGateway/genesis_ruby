# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Kyc
            # Stub class for VerificationInstructionsAttributes mixin
            class VerificationInstructionsAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::VerificationInstructionsAttributes

              public :verification_instructions_attributes_structure

            end
          end
        end
      end
    end
  end
end
