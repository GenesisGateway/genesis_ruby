# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Fraud
          module Reports
            # Date range based SAFE/TC40 retrieval allows you to fetch information for
            # all SAFE/TC40 reports for a given merchant within a given date range
            class DateRange < Api::Request

              include Api::Mixins::Requests::NonFinancial::DateAttributes
              include Api::Mixins::Requests::NonFinancial::PagingAttributes

              # Start of the requested date range
              def start_date
                @start_date&.strftime Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
              end

              # End of the requested date range
              def end_date
                @end_date&.strftime Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
              end

              # Date of import in the system
              def import_date
                @import_date&.strftime Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
              end

              # Date of import in the system
              def import_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # Start of the requested date range for the date when the fraud was reported
              def report_start_date
                @report_start_date&.strftime Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
              end

              # Start of the requested date range for the date when the fraud was reported
              def report_start_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # End of the requested date range for the date when the fraud was reported
              def report_end_date
                @report_end_date&.strftime Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
              end

              # End of the requested date range for the date when the fraud was reported
              def report_end_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              protected

              # Set Gateway API configuration
              def init_configuration
                init_xml_configuration
                init_api_gateway_configuration request_path: 'fraud_reports/by_date', include_token: false
                @api_config.parser_skip_root_node = false
              end

              # Field Validations
              def init_field_validations
                super

                field_value_dependencies.merge!(
                  {
                    start_date:        %i[end_date],
                    report_start_date: %i[report_end_date]
                  }
                )
              end

              # Custom field validations
              def check_requirements
                fields        = [start_date, import_date, report_start_date]
                error_message =
                  'Either start_date/end_date, import_date or report_start_date/report_end_date' \
                  ' fields have to be set, do not mix'

                raise ParameterError, error_message if fields.compact.size != 1

                super
              end

              # API Request structure
              def populate_structure # rubocop:disable Metrics/MethodLength
                @tree_structure = {
                  fraud_report_request: {
                    start_date:        start_date,
                    end_date:          end_date,
                    import_date:       import_date,
                    report_start_date: report_start_date,
                    report_end_date:   report_end_date,
                    page:              page,
                    per_page:          per_page
                  }
                }
              end

            end
          end
        end
      end
    end
  end
end
