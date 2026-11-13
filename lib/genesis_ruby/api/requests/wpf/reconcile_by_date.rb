# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Wpf
        # Reconcile by date range returns the WPF payments created within a given date range.
        # The response is paginated.
        class ReconcileByDate < Request

          include Mixins::Requests::NonFinancial::DateAttributes

          attr_reader :page, :records_per_page

          # The page within the paginated result
          def page=(value)
            parse_int attribute: __method__, value: value, allow_empty: true
          end

          # The number of records per page
          def records_per_page=(value)
            parse_int attribute: __method__, value: value, allow_empty: true
          end

          protected

          # Define WPF Reconcile by Date request configuration
          def init_configuration
            init_xml_configuration
            @api_config.url = build_request_url subdomain: 'wpf', path: 'wpf/reconcile/by_date'
          end

          def init_field_validations
            required_fields.push *%i[start_date]
          end

          # End date, when given, should not be before the start date
          def check_requirements
            super

            return unless @end_date && @end_date < @start_date

            raise ParameterError, 'End Date should not be before Start Date!'
          end

          # WPF Reconcile by Date request structure
          def populate_structure
            @tree_structure = {
              wpf_reconcile: {
                start_date:       start_date,
                end_date:         end_date,
                page:             page,
                records_per_page: records_per_page
              }
            }
          end

        end
      end
    end
  end
end
