# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Business
            # Furniture Attributes Stub
            class TravelAgenciesAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Business::TravelAgenciesAttributes

              public :travel_agencies_attributes_structure

            end
          end
        end
      end
    end
  end
end
