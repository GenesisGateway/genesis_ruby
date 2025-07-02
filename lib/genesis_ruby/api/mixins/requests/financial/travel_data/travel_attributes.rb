# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module TravelData
            # Travel Data Attributes
            module TravelAttributes

              include TravelData::AirlineItineraryAttributes
              include TravelData::CarRentalAttributes
              include TravelData::HotelRentalAttributes
              include TravelData::ReferenceTicketAttributes

              protected

              # Travel Data attributes structure
              def travel_data_attributes_structure
                {
                  ticket:  airline_attributes_structure.merge(reference_ticket_attributes_structure),
                  legs:    legs_structure,
                  taxes:   taxes_structure,
                  rentals: car_rental_attributes_structure.merge(hotel_rental_attributes_structure),
                  charges: charges_attributes_structure
                }
              end

            end
          end
        end
      end
    end
  end
end
