# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Customer Account Attributes Stub
          class CustomerAccountAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::CustomerAccountAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
