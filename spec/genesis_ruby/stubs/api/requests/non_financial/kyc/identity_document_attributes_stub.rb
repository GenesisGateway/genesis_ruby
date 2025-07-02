# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Kyc
            # Stub class for IdentityDocumentAttributes mixin
            class IdentityDocumentAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::IdentityDocumentAttributes

              public :get_doc

            end
          end
        end
      end
    end
  end
end
