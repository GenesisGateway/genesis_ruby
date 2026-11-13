# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          # Date-or-datetime from/to range attributes: start_date_from/start_date_to and
          # end_date_from/end_date_to. Mirrors the Genesis PHP DateTimeFromToAttributes trait.
          module DateTimeFromToAttributes

            # Start of the requested start-date range (inclusive, server-side)
            def start_date_from
              format_from_to_date @start_date_from, start_date_from_time?
            end

            # Start of the requested start-date range (inclusive, server-side)
            def start_date_from=(value)
              parse_from_to_date :start_date_from, :start_date_from_time, value
            end

            # End of the requested start-date range (non-inclusive, server-side)
            def start_date_to
              format_from_to_date @start_date_to, start_date_to_time?
            end

            # End of the requested start-date range (non-inclusive, server-side)
            def start_date_to=(value)
              parse_from_to_date :start_date_to, :start_date_to_time, value
            end

            # Start of the requested end-date range (inclusive, server-side)
            def end_date_from
              format_from_to_date @end_date_from, end_date_from_time?
            end

            # Start of the requested end-date range (inclusive, server-side)
            def end_date_from=(value)
              parse_from_to_date :end_date_from, :end_date_from_time, value
            end

            # End of the requested end-date range (non-inclusive, server-side)
            def end_date_to
              format_from_to_date @end_date_to, end_date_to_time?
            end

            # End of the requested end-date range (non-inclusive, server-side)
            def end_date_to=(value)
              parse_from_to_date :end_date_to, :end_date_to_time, value
            end

            private

            attr_accessor :start_date_from_time, :start_date_to_time,
                          :end_date_from_time, :end_date_to_time

            # Parses and assigns a from/to date, then records whether a time component was supplied.
            # The time flag is updated only after parse_date succeeds, so a failed assignment cannot
            # change the formatting of a previously stored valid date.
            def parse_from_to_date(attribute, time_attribute, value)
              parse_date attribute: attribute, value: value, allow_empty: true

              __send__ "#{time_attribute}=", Utils::Common.date_has_time?(value)
            end

            # Start Date From has time within the given string
            def start_date_from_time?
              self.start_date_from_time ||= false
            end

            # Start Date To has time within the given string
            def start_date_to_time?
              self.start_date_to_time ||= false
            end

            # End Date From has time within the given string
            def end_date_from_time?
              self.end_date_from_time ||= false
            end

            # End Date To has time within the given string
            def end_date_to_time?
              self.end_date_to_time ||= false
            end

            # Format a stored date, keeping the time component when it was provided
            def format_from_to_date(value, has_time)
              format = if has_time
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
                       else
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                       end

              value&.strftime format
            end

          end
        end
      end
    end
  end
end
