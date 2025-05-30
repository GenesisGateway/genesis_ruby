module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Kyc
            # Stub class for DocumentAttributesStub mixin
            class DocumentAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::DocumentAttributes

              public :document_attributes_structure

            end
          end
        end
      end
    end
  end
end
