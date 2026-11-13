# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/non_financial/scopes'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Fraud
          module Rdr
            # Date range based Rapid Dispute Resolution retrieval allows you to fetch information for all
            # rapid dispute resolutions for a given merchant within a given date range.
            #
            # Uses the current scope parameter contract. The deprecated processing_type / externally_processed
            # filters are intentionally not supported and never emitted.
            class DateRange < Api::Request

              include Api::Mixins::Requests::NonFinancial::DateAttributes
              include Api::Mixins::Requests::NonFinancial::PagingAttributes
              include Api::Mixins::Requests::NonFinancial::ScopeAttributes

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
                init_api_gateway_configuration request_path: 'rapid_dispute_resolutions/by_date', include_token: false
                @api_config.parser_skip_root_node = false
              end

              # Field Validations
              def init_field_validations
                super

                required_fields.push *%i[scope]
              end

              # Rapid Dispute Resolution custom field validations
              def check_requirements
                unless @start_date.nil? ^ @import_date.nil?
                  raise ParameterError, 'Either start_date or import_date field has to be set, not both.'
                end

                if @start_date && @end_date && @start_date > @end_date
                  raise ParameterError, 'start_date cannot be later than end_date.'
                end

                super
              end

              # API Request structure
              def populate_structure
                @tree_structure = {
                  rapid_dispute_resolution_request: {
                    start_date:  start_date,
                    end_date:    end_date,
                    import_date: import_date,
                    page:        page,
                    per_page:    per_page,
                    scope:       scope
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
