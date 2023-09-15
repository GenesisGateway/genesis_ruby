module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Business
            # Mixin Event Management Attributes
            module EventManagementAttributes

              attr_accessor :business_event_organizer_id, :business_event_id

              # The date when event starts
              def business_event_start_date
                @business_event_start_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The date when event starts
              def business_event_start_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # The date when event ends
              def business_event_end_date
                @business_event_end_date&.strftime(
                  GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                )
              end

              # The date when event ends
              def business_event_end_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              protected

              # Event Management Attributes Structure
              def event_management_attributes_structure
                {
                  event_start_date:   business_event_start_date,
                  event_end_date:     business_event_end_date,
                  event_organizer_id: business_event_organizer_id,
                  event_id:           business_event_id
                }
              end

            end
          end
        end
      end
    end
  end
end
