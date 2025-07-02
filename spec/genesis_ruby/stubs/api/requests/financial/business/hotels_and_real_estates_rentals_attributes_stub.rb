# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Business
            # Hotels and Real Estates Rentals Attributes Stub
            class HotelsAndRealEstatesRentalsAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Business::HotelsAndRealEstateRentalsAttributes

              public :hotels_and_real_estate_rentals_attributes_structure

            end
          end
        end
      end
    end
  end
end
