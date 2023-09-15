require 'genesis_ruby/api/mixins/requests/financial/business/airlines_air_carriers_attributes'
require 'genesis_ruby/api/mixins/requests/financial/business/car_plane_and_boat_rentals_attributes'
require 'genesis_ruby/api/mixins/requests/financial/business/cruise_lines_attributes'
require 'genesis_ruby/api/mixins/requests/financial/business/event_management_attributes'
require 'genesis_ruby/api/mixins/requests/financial/business/furniture_attributes'
require 'genesis_ruby/api/mixins/requests/financial/business/hotels_and_real_estate_rentals_attributes'
require 'genesis_ruby/api/mixins/requests/financial/business/travel_agencies_attributes'
require 'genesis_ruby/api/constants/transactions/parameters/business/payment_types'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Business
            # Mixin Business Attributes
            module BusinessAttributes

              include AirlinesAirCarriersAttributes
              include CarPlaneAndBoatRentalsAttributes
              include CruiseLinesAttributes
              include EventManagementAttributes
              include FurnitureAttributes
              include HotelsAndRealEstateRentalsAttributes
              include TravelAgenciesAttributes

              attr_reader :business_payment_type

              # The type of payment - can be either deposit or balance
              def business_payment_type=(value)
                allowed_options attribute:   __method__,
                                allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::Business::
                                    PaymentTypes.all,
                                value:       value,
                                allow_empty: true
              end

              protected

              # Business Attributes Structure
              def business_attributes_structure
                {
                  payment_type: business_payment_type
                }.merge airlines_air_carriers_attributes_structure, car_plane_and_boat_rentals_attributes_structure,
                        cruise_lines_attributes_structure, event_management_attributes_structure,
                        furniture_attributes_structure, hotels_and_real_estate_rentals_attributes_structure,
                        travel_agencies_attributes_structure
              end

            end
          end
        end
      end
    end
  end
end
