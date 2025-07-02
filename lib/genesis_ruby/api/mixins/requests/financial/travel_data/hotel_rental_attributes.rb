# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module TravelData
            # Hotel Rental Attributes
            module HotelRentalAttributes

              attr_reader :travel_hotel_rental_purchase_identifier, :travel_hotel_rental_customer_code,
                          :travel_hotel_rental_extra_charges, :travel_hotel_rental_no_show_indicator

              # Hotel Rental Purchase Identifier
              def travel_hotel_rental_purchase_identifier=(value)
                limited_string attribute: __method__, value: value, max: 10
              end

              # Travel Data Arrival date
              def travel_hotel_rental_arrival_date
                @travel_hotel_rental_arrival_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::
                    DD_MM_YYYY_L_HYPHENS
              end

              # Travel Data Arrival Date
              def travel_hotel_rental_arrival_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Travel Data Departure date
              def travel_hotel_rental_departure_date
                @travel_hotel_rental_departure_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::
                    DD_MM_YYYY_L_HYPHENS
              end

              # Travel Data Departure Date
              def travel_hotel_rental_departure_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Travel Data Customer Code
              def travel_hotel_rental_customer_code=(value)
                limited_string attribute: __method__, value: value, max: 17
              end

              # Travel Data Extra Charges
              def travel_hotel_rental_extra_charges=(value)
                allowed_options attribute: __method__, value: value, allow_empty: true, allowed: [*2..7]
              end

              # Travel Data No Show Indicator
              def travel_hotel_rental_no_show_indicator=(value)
                allowed_options attribute: __method__, value: value, allow_empty: true, allowed: [0, 1]
              end

              protected

              # Hotel Rental attributes structure
              def hotel_rental_attributes_structure
                {
                  hotel_rental: {
                    purchase_identifier: travel_hotel_rental_purchase_identifier,
                    arrival_date:        travel_hotel_rental_arrival_date,
                    departure_date:      travel_hotel_rental_departure_date,
                    customer_code:       travel_hotel_rental_customer_code,
                    extra_charges:       travel_hotel_rental_extra_charges,
                    no_show_indicator:   travel_hotel_rental_no_show_indicator
                  }
                }
              end

            end
          end
        end
      end
    end
  end
end
