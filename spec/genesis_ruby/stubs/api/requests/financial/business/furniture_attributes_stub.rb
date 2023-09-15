module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Business
            # Furniture Attributes Stub
            class FurnitureAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Business::FurnitureAttributes

              public :furniture_attributes_structure

            end
          end
        end
      end
    end
  end
end
