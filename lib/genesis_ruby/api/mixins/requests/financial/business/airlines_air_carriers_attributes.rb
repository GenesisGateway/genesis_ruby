module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Business
            # Mixin Airlines Air Carriers Attributes
            module AirlinesAirCarriersAttributes

              attr_accessor :business_airline_code, :business_airline_flight_number, :business_flight_ticket_number,
                            :business_flight_origin_city, :business_flight_destination_city,
                            :business_airline_tour_operator_name

              # The date when the flight arrives
              def business_flight_arrival_date
                @business_flight_arrival_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The date when the flight arrives
              def business_flight_arrival_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # The date when the flight departs
              def business_flight_departure_date
                @business_flight_departure_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The date when the flight departs
              def business_flight_departure_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              protected

              # Airlines Air Carriers Attributes Structure
              def airlines_air_carriers_attributes_structure
                {
                  flight_arrival_date:        business_flight_arrival_date,
                  flight_departure_date:      business_flight_departure_date,
                  airline_code:               business_airline_code,
                  airline_flight_number:      business_airline_flight_number,
                  flight_ticket_number:       business_flight_ticket_number,
                  flight_origin_city:         business_flight_origin_city,
                  flight_destination_city:    business_flight_destination_city,
                  airline_tour_operator_name: business_airline_tour_operator_name
                }
              end

            end
          end
        end
      end
    end
  end
end
