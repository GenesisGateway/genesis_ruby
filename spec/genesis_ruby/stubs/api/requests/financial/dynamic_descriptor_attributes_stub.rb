module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Dynamic Descriptor Attributes Stub
          class DynamicDescriptorAttributesStub

            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
            include GenesisRuby::Api::Mixins::Requests::Financial::DynamicDescriptorAttributes

            public :dynamic_descriptor_structure

          end
        end
      end
    end
  end
end
