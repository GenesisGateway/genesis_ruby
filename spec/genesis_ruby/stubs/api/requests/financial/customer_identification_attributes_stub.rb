# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Customer Identification Attributes Stub
          class CustomerIdentificationAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::CustomerIdentificationAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
