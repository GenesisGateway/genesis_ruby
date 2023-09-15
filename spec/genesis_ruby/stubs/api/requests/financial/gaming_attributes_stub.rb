module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          class GamingAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::GamingAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
