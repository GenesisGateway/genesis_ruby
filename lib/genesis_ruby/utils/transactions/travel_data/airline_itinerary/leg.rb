require 'genesis_ruby/utils/transactions/travel_data/airline_itinerary/base'

module GenesisRuby
  module Utils
    module Transactions
      module TravelData
        module AirlineItinerary
          # Signify a single AirlineItinerary Leg data
          class Leg < Base

            attr_reader :carrier_code, :service_class, :origin_city, :destination_city, :fare_basis_code,
                        :flight_number, :departure_time_segment, :stopover_code
            attr_accessor :departure_time

            # Departure date
            def departure_date
              @departure_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
            end

            # Departure date
            def departure_date=(value)
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            # Arrival date
            def arrival_date
              @arrival_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
            end

            # Arrival date
            def arrival_date=(value)
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            # Carrier Code
            def carrier_code=(value)
              limited_string attribute: __method__, value: value.to_s, max: 2
            end

            # Service Class
            def service_class=(value)
              limited_string attribute: __method__, value: value.to_s, max: 1
            end

            # Origin City
            def origin_city=(value)
              limited_string attribute: __method__, value: value.to_s, max: 3
            end

            # Destination City
            def destination_city=(value)
              limited_string attribute: __method__, value: value.to_s, max: 3
            end

            # Fare basis code
            def fare_basis_code=(value)
              limited_string attribute: __method__, value: value.to_s, max: 6
            end

            # Flight number
            def flight_number=(value)
              limited_string attribute: __method__, value: value.to_s, max: 5
            end

            # Departure time segment
            def departure_time_segment=(value)
              allowed_options attribute: __method__, value: value.to_s, allowed: %w(A P), allow_empty: true
            end

            # Stopover code
            def stopover_code=(value)
              allowed_options attribute: __method__, value: value, allowed: [0, 1], allow_empty: true
            end

            # Get Single Leg structure
            def attributes_structure # rubocop:disable Metrics/MethodLength
              {
                departure_date:         departure_date,
                arrival_date:           arrival_date,
                carrier_code:           carrier_code,
                service_class:          service_class,
                origin_city:            origin_city,
                destination_city:       destination_city,
                stopover_code:          stopover_code,
                fare_basis_code:        fare_basis_code,
                flight_number:          flight_number,
                departure_time:         departure_time,
                departure_time_segment: departure_time_segment
              }
            end

          end
        end
      end
    end
  end
end
