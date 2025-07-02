# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Threeds
            module Version2
              # Mixin ThreedsV2 Recurring
              module Recurring

                attr_reader :threeds_v2_recurring_frequency

                # A future date indicating the end date for any further subsequent transactions
                def threeds_v2_recurring_expiration_date
                  @threeds_v2_recurring_expiration_date&.strftime(
                    GenesisRuby::Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
                  )
                end

                # A future date indicating the end date for any further subsequent transactions
                def threeds_v2_recurring_expiration_date=(value)
                  parse_date attribute: __method__, value: value, allow_empty: true
                end

                # Indicates the minimum number of days between subsequent transactions
                def threeds_v2_recurring_frequency=(value)
                  limited_string attribute: __method__,
                                 value:     value.to_s.empty? || !value.to_i.positive? ? nil : value.to_i,
                                 max:       4
                end

                protected

                # Request Recurring Attributes structure
                def recurring_attributes
                  {
                    expiration_date: threeds_v2_recurring_expiration_date,
                    frequency:       threeds_v2_recurring_frequency
                  }
                end

              end
            end
          end
        end
      end
    end
  end
end
