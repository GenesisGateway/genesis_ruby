# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module TravelData
            # Car Rental Attributes Stub
            class CarRentalAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::TravelData::CarRentalAttributes

            end
          end
        end
      end
    end
  end
end
