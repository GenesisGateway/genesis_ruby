module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module TravelData
            # Car Rental attributes
            module CarRentalAttributes

              attr_reader :travel_car_rental_purchase_identifier, :travel_car_rental_class_id,
                          :travel_car_rental_renter_name, :travel_car_rental_return_city,
                          :travel_car_rental_return_state, :travel_car_rental_return_country,
                          :travel_car_rental_renter_return_location_id, :travel_car_rental_customer_code,
                          :travel_car_rental_extra_charges, :travel_car_rental_no_show_indicator

              # Travel Data Purchase Identifier
              def travel_car_rental_purchase_identifier=(value)
                limited_string attribute: __method__, value: value, max: 9
              end

              # Travel Data Class id
              def travel_car_rental_class_id=(value)
                allowed_options attribute: __method__,
                                value: value.to_i,
                                allow_empty: true,
                                allowed: [*1..30].push(9999)
              end

              # Travel Data PickUp Date
              def travel_car_rental_pickup_date
                @travel_car_rental_pickup_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::
                    DD_MM_YYYY_L_HYPHENS
              end

              # Travel Data PickUp Date
              def travel_car_rental_pickup_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Travel Data Renter Name
              def travel_car_rental_renter_name=(value)
                limited_string attribute: __method__, value: value, max: 20
              end

              # Travel Data Return City
              def travel_car_rental_return_city=(value)
                limited_string attribute: __method__, value: value, max: 18
              end

              # Travel Data Return State
              def travel_car_rental_return_state=(value)
                limited_string attribute: __method__, value: value, max: 3
              end

              # Travel Data Return Country
              def travel_car_rental_return_country=(value)
                limited_string attribute: __method__, value: value, max: 3
              end

              # Travel Data Return Date
              def travel_car_rental_return_date
                @travel_car_rental_return_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::
                    DD_MM_YYYY_L_HYPHENS
              end

              # Travel Data Return Date
              def travel_car_rental_return_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Travel Data Renter Return Location id
              def travel_car_rental_renter_return_location_id=(value)
                limited_string attribute: __method__, value: value, max: 10
              end

              # Travel Data Customer Code
              def travel_car_rental_customer_code=(value)
                limited_string attribute: __method__, value: value, max: 17
              end

              # Travel Data Extra Charges
              def travel_car_rental_extra_charges=(value)
                allowed_options attribute: __method__, value: value.to_i, allow_empty: true, allowed: [*1..5]
              end

              # Travel Data No Show Indicator
              def travel_car_rental_no_show_indicator=(value)
                allowed_options attribute: __method__, value: value.to_i, allow_empty: true, allowed: [0, 1]
              end

              protected

              # Travel Data Car Rental Attributes Structure
              def car_rental_attributes_structure # rubocop:disable Metrics/MethodLength
                {
                  car_rental: {
                    purchase_identifier:       travel_car_rental_purchase_identifier,
                    class_id:                  travel_car_rental_class_id,
                    pickup_date:               travel_car_rental_pickup_date,
                    renter_name:               travel_car_rental_renter_name,
                    return_city:               travel_car_rental_return_city,
                    return_state:              travel_car_rental_return_state,
                    return_country:            travel_car_rental_return_country,
                    return_date:               travel_car_rental_return_date,
                    renter_return_location_id: travel_car_rental_renter_return_location_id,
                    customer_code:             travel_car_rental_customer_code,
                    extra_charges:             travel_car_rental_extra_charges,
                    no_show_indicator:         travel_car_rental_no_show_indicator
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
