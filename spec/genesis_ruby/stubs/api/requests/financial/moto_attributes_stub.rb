module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          class MotoAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::MotoAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
