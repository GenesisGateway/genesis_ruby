module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # SCA Attributes Stub
          class ScaAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::ScaAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

            public :sca_attributes_structure

          end
        end
      end
    end
  end
end
