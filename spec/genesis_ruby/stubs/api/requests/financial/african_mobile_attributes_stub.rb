# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          class AfricanMobileAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::AfricanMobileAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
