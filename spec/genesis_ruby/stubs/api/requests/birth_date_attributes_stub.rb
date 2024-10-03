module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          class BirthDateAttributesStub

            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
            include GenesisRuby::Api::Mixins::Requests::BirthDateAttributes

          end
        end
      end
    end
  end
end
