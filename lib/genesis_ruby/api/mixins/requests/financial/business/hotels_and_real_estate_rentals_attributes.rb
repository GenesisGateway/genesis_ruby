# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Business
            # Mixin Hotels and Real Estate Rentals Attributes
            module HotelsAndRealEstateRentalsAttributes

              attr_accessor :business_travel_agency_name

              # The data when the customer check-in
              def business_check_in_date
                @business_check_in_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The data when the customer check-in
              def business_check_in_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # The data when the customer check-out
              def business_check_out_date
                @business_check_out_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The data when the customer check-out
              def business_check_out_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              protected

              # Hotels and Real Estate Rentals Attributes Structure
              def hotels_and_real_estate_rentals_attributes_structure
                {
                  check_in_date:      business_check_in_date,
                  check_out_date:     business_check_out_date,
                  travel_agency_name: business_travel_agency_name
                }
              end

            end
          end
        end
      end
    end
  end
end
