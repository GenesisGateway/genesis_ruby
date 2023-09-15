module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Business
            # Mixin Travel Agencies Attributes
            module TravelAgenciesAttributes

              attr_accessor :business_carrier_code, :business_flight_number, :business_ticket_number,
                            :business_origin_city, :business_destination_city, :business_travel_agency,
                            :business_contractor_name, :business_atol_certificate

              # The date of arrival
              def business_arrival_date
                @business_arrival_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The date of arrival
              def business_arrival_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # The date of departure
              def business_departure_date
                @business_departure_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The date of departure
              def business_departure_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Pick-up date
              def business_pick_up_date
                @business_pick_up_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # Pick-up date
              def business_pick_up_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Return date
              def business_return_date
                @business_return_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # Return date
              def business_return_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              protected

              # Travel Agencies Attributes Structure
              def travel_agencies_attributes_structure # rubocop:disable Metrics/MethodLength
                {
                  arrival_date:     business_arrival_date,
                  departure_date:   business_departure_date,
                  carrier_code:     business_carrier_code,
                  flight_number:    business_flight_number,
                  ticket_number:    business_ticket_number,
                  origin_city:      business_origin_city,
                  destination_city: business_destination_city,
                  travel_agency:    business_travel_agency,
                  contractor_name:  business_contractor_name,
                  atol_certificate: business_atol_certificate,
                  pick_up_date:     business_pick_up_date,
                  return_date:      business_return_date
                }
              end

            end
          end
        end
      end
    end
  end
end
