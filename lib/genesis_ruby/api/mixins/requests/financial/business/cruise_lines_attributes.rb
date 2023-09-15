module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Business
            # Mixin Cruise Lines Attributes
            module CruiseLinesAttributes

              # The date when cruise begins
              def business_cruise_start_date
                @business_cruise_start_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The date when cruise begins
              def business_cruise_start_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # The date when cruise ends
              def business_cruise_end_date
                @business_cruise_end_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The date when cruise ends
              def business_cruise_end_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              protected

              # Cruise Lines Attributes Structure
              def cruise_lines_attributes_structure
                {
                  cruise_start_date: business_cruise_start_date,
                  cruise_end_date:   business_cruise_end_date
                }
              end

            end
          end
        end
      end
    end
  end
end
