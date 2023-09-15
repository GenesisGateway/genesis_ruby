module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Business
            # Mixin Car Plane and Boat Rentals Attributes
            module CarPlaneAndBoatRentalsAttributes

              attr_accessor :business_supplier_name

              # The date when customer takes the vehicle
              def business_vehicle_pick_up_date
                @business_vehicle_pick_up_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The date when customer takes the vehicle
              def business_vehicle_pick_up_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # The date when the customer returns the vehicle back
              def business_vehicle_return_date
                @business_vehicle_return_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The date when the customer returns the vehicle back
              def business_vehicle_return_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              protected

              # Car Plane and Boat Rentals Attributes Structure
              def car_plane_and_boat_rentals_attributes_structure
                {
                  vehicle_pick_up_date: business_vehicle_pick_up_date,
                  vehicle_return_date:  business_vehicle_return_date,
                  supplier_name:        business_supplier_name
                }
              end

            end
          end
        end
      end
    end
  end
end
