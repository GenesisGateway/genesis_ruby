module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Business
            # Event Management Attributes Stub
            class EventManagementAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Business::EventManagementAttributes

              public :event_management_attributes_structure

            end
          end
        end
      end
    end
  end
end
