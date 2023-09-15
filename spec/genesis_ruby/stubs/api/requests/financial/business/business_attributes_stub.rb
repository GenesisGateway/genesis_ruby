module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Business
            # Business Attributes Stub
            class BusinessAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Business::BusinessAttributes

              public :business_attributes_structure

            end
          end
        end
      end
    end
  end
end
