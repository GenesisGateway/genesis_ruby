# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Kyc
            # Stub class for FaceAttributes mixin
            class FaceAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::FaceAttributes

              public :face_attributes_structure

            end
          end
        end
      end
    end
  end
end
