# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          # Date Attributes mixin
          module DateAttributes

            # Start of the requested date range (time is optional)
            def start_date
              format = if start_date_time?
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
                       else
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                       end
              @start_date&.strftime format
            end

            # Start of the requested date range (time is optional)
            def start_date=(value)
              self.start_date_time = Utils::Common.date_has_time? value
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            # End of the requested date range (time is optional)
            def end_date
              format = if end_date_time?
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
                       else
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                       end
              @end_date&.strftime format
            end

            # End of the requested date range (time is optional)
            def end_date=(value)
              self.end_date_time = Utils::Common.date_has_time? value
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            # Start of the requested date range in UTC.
            def start_date_from
              format = if start_date_from_time?
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
                       else
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                       end
              @start_date_from&.strftime format
            end

            # Start of the requested date range in UTC.
            def start_date_from=(value)
              self.start_date_from_time = Utils::Common.date_has_time? value
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            # End of the requested date range in UTC.
            def start_date_to
              format = if start_date_to_time?
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
                       else
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                       end
              @start_date_to&.strftime format
            end

            # End of the requested date range in UTC.
            def start_date_to=(value)
              self.start_date_to_time = Utils::Common.date_has_time? value
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            # Start of the requested date range in UTC.
            def end_date_from
              format = if end_date_from_time?
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
                       else
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                       end
              @end_date_from&.strftime format
            end

            # Start of the requested date range in UTC.
            def end_date_from=(value)
              self.end_date_from_time = Utils::Common.date_has_time? value
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            # End of the requested date range in UTC.
            def end_date_to
              format = if end_date_to_time?
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
                       else
                         Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                       end
              @end_date_to&.strftime format
            end

            # End of the requested date range in UTC.
            def end_date_to=(value)
              self.end_date_to_time = Utils::Common.date_has_time? value
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            private

            attr_accessor :start_date_time, :end_date_time,
                          :start_date_from_time, :start_date_to_time,
                          :end_date_from_time, :end_date_to_time

            # Start Date has time within the given string
            def start_date_time?
              self.start_date_time ||= false
            end

            # End Date has time within the given string
            def end_date_time?
              self.end_date_time ||= false
            end

            # Start Date has time within the given string
            def start_date_from_time?
              self.start_date_from_time ||= false
            end

            # End Date has time within the given string
            def start_date_to_time?
              self.start_date_to_time ||= false
            end

            # End Date has time within the given string
            def end_date_from_time?
              self.end_date_from_time ||= false
            end

            # End Date has time within the given string
            def end_date_to_time?
              self.end_date_to_time ||= false
            end

          end
        end
      end
    end
  end
end
