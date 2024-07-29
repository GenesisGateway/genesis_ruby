require 'genesis_ruby/utils/transactions/travel_data/airline_itinerary/leg'
require 'genesis_ruby/utils/transactions/travel_data/airline_itinerary/tax'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module TravelData
            # Level 3 Data Airline Itinerary Attributes
            module AirlineItineraryAttributes

              attr_reader :travel_aid_restricted_ticket_indicator, :travel_aid_ticket_number,
                          :travel_aid_passenger_name, :travel_aid_customer_code, :travel_aid_issuing_carrier,
                          :travel_aid_agency_name, :travel_aid_agency_code
              attr_accessor :travel_aid_total_fare, :travel_aid_confirmation_information

              # Date Of Issue
              def travel_aid_date_of_issue
                @travel_aid_date_of_issue&.strftime GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
              end

              # Date Of Issue
              def travel_aid_date_of_issue=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Restricted Ticket Indicator
              def travel_aid_restricted_ticket_indicator=(value)
                allowed_options attribute: __method__, value: value.to_i, allow_empty: true, allowed: [0, 1]
              end

              # Ticket Number
              def travel_aid_ticket_number=(value)
                limited_string attribute: __method__, value: value, max: 15
              end

              # Passenger name
              def travel_aid_passenger_name=(value)
                limited_string attribute: __method__, value: value, max: 29
              end

              # Customer code
              def travel_aid_customer_code=(value)
                limited_string attribute: __method__, value: value, max: 17
              end

              # Issuing carrier
              def travel_aid_issuing_carrier=(value)
                limited_string attribute: __method__, value: value, max: 4
              end

              # Agency name
              def travel_aid_agency_name=(value)
                limited_string attribute: __method__, value: value, max: 30
              end

              # Agency code
              def travel_aid_agency_code=(value)
                limited_string attribute: __method__, value: value, max: 8
              end

              # AirlineItinerary Legs data. Max legs 10
              def travel_aid_legs
                @travel_aid_legs || []
              end

              # AirlineItinerary Taxes data. Max taxes 10
              def travel_aid_taxes
                @travel_aid_taxes || []
              end

              # Add a single AirlineItinerary Leg data
              def add_travel_aid_leg(leg)
                @travel_aid_legs ||= travel_aid_legs
                leg_obj      = GenesisRuby::Utils::Transactions::TravelData::AirlineItinerary::Leg

                raise InvalidArgumentError, "Leg must be instance of #{leg_obj.name}" unless leg.instance_of? leg_obj

                if travel_aid_legs.count == ALLOWED_ITEMS_COUNT
                  raise InvalidArgumentError, "Allowed Legs count exceeded. Allowed #{ALLOWED_ITEMS_COUNT}."
                end

                @travel_aid_legs.push leg
              end

              # Add a single AirlineItinerary Tax data
              def add_travel_aid_tax(tax)
                @travel_aid_taxes ||= travel_aid_taxes
                tax_obj       = GenesisRuby::Utils::Transactions::TravelData::AirlineItinerary::Tax

                raise InvalidArgumentError, "Tax must be instance of #{tax_obj.name}" unless tax.instance_of? tax_obj

                if travel_aid_taxes.count == ALLOWED_ITEMS_COUNT
                  raise InvalidArgumentError, "Allowed Legs count exceeded. Allowed #{ALLOWED_ITEMS_COUNT}."
                end

                @travel_aid_taxes.push tax
              end

              # Reset Legs data
              def clear_travel_aid_legs
                @travel_aid_legs = []
              end

              # Reset Taxes
              def clear_travel_aid_taxes
                @travel_aid_taxes = []
              end

              protected

              ALLOWED_ITEMS_COUNT = 10

              # Legs structure
              def legs_structure
                parse_items 'leg', travel_aid_legs
              end

              # Taxes structure
              def taxes_structure
                parse_items 'tax', travel_aid_taxes
              end

              # Prepare structure
              def parse_items(node_name, items)
                data = []

                items.each do |item|
                  item.currency = currency if item.respond_to?(:currency) && respond_to?(:currency)
                  data.push item.attributes_structure
                end

                Hash[node_name.to_sym, data]
              end

              # Attributes Structure
              def airline_attributes_structure # rubocop:disable RSpec/MethodLength
                {
                  ticket_number:               travel_aid_ticket_number,
                  passenger_name:              travel_aid_passenger_name,
                  customer_code:               travel_aid_customer_code,
                  restricted_ticket_indicator: travel_aid_restricted_ticket_indicator,
                  issuing_carrier:             travel_aid_issuing_carrier,
                  total_fare:                  parse_total_fare,
                  agency_name:                 travel_aid_agency_name,
                  agency_code:                 travel_aid_agency_code,
                  confirmation_information:    travel_aid_confirmation_information,
                  date_of_issue:               travel_aid_date_of_issue
                }
              end

              # Parse Total Fare amount
              def parse_total_fare
                return travel_aid_total_fare if currency.nil? || travel_aid_total_fare.nil?

                transform_amount travel_aid_total_fare, currency
              end

            end
          end
        end
      end
    end
  end
end
