# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Reconcile
          # Date range based reconciliation allows you to fetch information for all payment transactions from
          # a terminal within a given date range.
          # The response is paginated, each request will return 100 entries max.
          class DateRange < Api::Requests::Base::NonFinancial::Reconcile::Base

            include Api::Mixins::Requests::NonFinancial::DateAttributes

            # Maximum range between start_date and end_date in days
            MAX_RANGE_DAYS              = 7
            # Maximum range between start_date and end_date in days, when Smart Router is used
            MAX_RANGE_DAYS_SMART_ROUTER = 1

            attr_reader :page

            # The page within the paginated result, defaults to 1
            def page=(value)
              @page = value&.to_i
            end

            protected

            # The Reconcile API path
            def request_path
              'reconcile/by_date'
            end

            # Set Gateway API configuration
            def init_configuration
              super
              @api_config.parser_skip_root_node = false
            end

            def init_field_validations
              required_fields.push *%i[start_date end_date]
            end

            # Validate the requirements and the date range
            def check_requirements
              super
              validate_date_range
            end

            # End date should not be before the start date and the range should not exceed the allowed maximum
            def validate_date_range
              raise ParameterError, 'End Date should not be before Start Date!' if @end_date < @start_date

              max_days = smart_router_active? ? MAX_RANGE_DAYS_SMART_ROUTER : MAX_RANGE_DAYS
              return unless (@end_date - @start_date) > max_days

              raise ParameterError, "Max difference between start_date and end_date is #{max_days} day(s)!"
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

          end
        end
      end
    end
  end
end
