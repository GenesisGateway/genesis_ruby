# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/non_financial/externally_processed'
require 'genesis_ruby/api/constants/transactions/parameters/non_financial/processing_type'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module ProcessedTransactions
          # Post Date range based processed transaction retrieval allows you to fetch information for
          # all processed transactions for a given merchant within a given post date range.
          class PostDateRange < Request

            include Api::Mixins::Requests::NonFinancial::DateAttributes
            include Api::Mixins::Requests::NonFinancial::PagingAttributes

            attr_accessor :batch_number, :batch_slip_number, :deposit_slip_number, :externally_processed,
                          :processing_type

            # Start of the requested date range
            def start_date
              @start_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
            end

            # End of the requested date range
            def end_date
              @end_date&.strftime GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
            end

            protected

            # Processed Transactions API DateRange request configuration
            def init_configuration
              init_xml_configuration
              @api_config.parser_skip_root_node = false

              init_api_gateway_configuration request_path: 'processed_transactions/by_post_date', include_token: false
            end

            # Processed Transactions API DateRange field validations
            def init_field_validations
              super

              required_fields.push *%i[start_date]
              field_values.merge! externally_processed: Constants::Transactions::Parameters::NonFinancial::
                                      ExternallyProcessed.all,
                                  processing_type:      Constants::Transactions::Parameters::NonFinancial::
                                      ProcessingType.all
            end

            # Processed Transactions API DateRange request structure
            def populate_structure # rubocop:disable Metrics/MethodLength
              @tree_structure = {
                processed_transaction_request: {
                  start_date:           start_date,
                  end_date:             end_date,
                  batch_number:         batch_number,
                  batch_slip_number:    batch_slip_number,
                  deposit_slip_number:  deposit_slip_number,
                  externally_processed: externally_processed,
                  processing_type:      processing_type,
                  page:                 page,
                  per_page:             per_page
                }
              }
            end

          end
        end
      end
    end
  end
end
