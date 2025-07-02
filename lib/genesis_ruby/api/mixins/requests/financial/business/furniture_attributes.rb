# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Business
            # Mixin Furniture Attributes
            module FurnitureAttributes

              attr_accessor :business_name_of_the_supplier

              # The date when order was placed
              def business_date_of_order
                @business_date_of_order&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The date when order was placed
              def business_date_of_order=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Date of the expected delivery
              def business_delivery_date
                @business_delivery_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # Date of the expected delivery
              def business_delivery_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              protected

              # Furniture Attributes Structure
              def furniture_attributes_structure
                {
                  date_of_order:        business_date_of_order,
                  delivery_date:        business_delivery_date,
                  name_of_the_supplier: business_name_of_the_supplier
                }
              end

            end
          end
        end
      end
    end
  end
end
