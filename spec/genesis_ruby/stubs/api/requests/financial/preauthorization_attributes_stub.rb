module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          class PreauthorizationAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::PreauthorizationAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
