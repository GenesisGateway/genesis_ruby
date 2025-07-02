# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/non_financial/externally_processed'
require 'genesis_ruby/api/constants/transactions/parameters/non_financial/processing_type'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Fraud
          module Chargeback
            # Date range based chargeback retrieval allows you to fetch information for all
            # chargebacks for a given merchant within a given date range
            class DateRange < Api::Request

              include Api::Mixins::Requests::NonFinancial::DateAttributes
              include Api::Mixins::Requests::NonFinancial::PagingAttributes

              attr_accessor :externally_processed, :processing_type

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

              protected

              # Set Gateway API configuration
              def init_configuration
                init_xml_configuration
                init_api_gateway_configuration request_path: 'chargebacks/by_date', include_token: false
                @api_config.parser_skip_root_node = false
              end

              # Field Validations
              def init_field_validations
                super

                constant_values = {
                  externally_processed: Constants::Transactions::Parameters::NonFinancial::ExternallyProcessed.all,
                  processing_type:      Constants::Transactions::Parameters::NonFinancial::ProcessingType.all
                }

                required_fields.push *%i[start_date]
                field_values.merge! constant_values
              end

              # API Request structure
              def populate_structure # rubocop:disable Metrics/MethodLength
                @tree_structure = {
                  chargeback_request: {
                    start_date:           start_date,
                    end_date:             end_date,
                    import_date:          import_date,
                    page:                 page,
                    per_page:             per_page,
                    externally_processed: externally_processed,
                    processing_type:      processing_type
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
