module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Reconcile
          # Date range based reconciliation allows you to fetch information for all payment transactions from
          # a terminal within a given date range.
          # The response is paginated, each request will return 100 entries max.
          class DateRange < Api::Request

            include Api::Mixins::Requests::NonFinancial::DateAttributes

            attr_reader :page

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

            def init_field_validations
              required_fields.push *%i[start_date]
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
