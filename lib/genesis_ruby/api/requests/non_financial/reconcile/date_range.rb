module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Reconcile
          # Date range based reconciliation allows you to fetch information for all payment transactions from
          # a terminal within a given date range.
          # The response is paginated, each request will return 100 entries max.
          class DateRange < Api::Request

            attr_reader :page

            # Start of the requested date range (time is optional)
            def start_date
              format = if start_date_time?
                         Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
                       else
                         Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                       end

              @start_date&.strftime format
            end

            # Start of the requested date range (time is optional)
            def start_date=(value)
              self.start_date_time = Utils::Common.date_has_time? value

              parse_date attribute: __method__, value: value, allow_empty: false
            end

            # Start of the requested date range (time is optional)
            def end_date
              format = if end_date_time?
                         Constants::DateTimeFormats::YYYY_MM_DD_H_I_S
                       else
                         Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                       end

              @end_date&.strftime format
            end

            # End of the requested date range (time is optional)
            def end_date=(value)
              self.end_date_time = Utils::Common.date_has_time? value

              parse_date attribute: __method__, value: value, allow_empty: true
            end

            # The page within the paginated result, defaults to 1
            def page=(value)
              @page = value&.to_i
            end

            protected

            # Set Gateway API configuration
            def init_configuration
              init_xml_configuration
              init_api_gateway_configuration request_path: 'reconcile/by_date'
              @api_config.parser_skip_root_node = false
            end

            def init_required_fields
              self.required_fields = %i[start_date]
            end

            # API Request structure
            def populate_structure
              @tree_structure = {
                reconcile: {
                  start_date: start_date,
                  end_date:   end_date,
                  page:       page
                }
              }
            end

            private

            attr_accessor :start_date_time, :end_date_time

            # Start Date has time within the given string
            def start_date_time?
              self.start_date_time ||= false
            end

            # End Date has time within the given string
            def end_date_time?
              self.end_date_time ||= false
            end

          end
        end
      end
    end
  end
end
