# frozen_string_literal: true

require 'date'
require 'genesis_ruby/api/constants/date_time_formats'
require 'genesis_ruby/api/constants/currencies/iso4217'
require 'genesis_ruby/api/constants/transactions/parameters/non_financial/billing_api/statement_response_fields'
require 'genesis_ruby/api/requests/base/non_financial/billing_api/base'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module BillingApi
          # Billing Statements API request
          class Statement < Base::NonFinancial::BillingApi::Base # rubocop:disable Metrics/ClassLength

            MAX_COUNT_BILLING_STATEMENT = 1_000
            MAX_DAYS_DIFFERENCE         = 7

            # Allowed values for the +status+ filter
            STATUSES          = %w(open pending paid bounced).freeze

            # Allowed values for the +sort_by_field+ parameter
            ORDER_BY_FIELDS   = %w(billingStatement creationDate startDate endDate valueDate
                                   currency status masterAccountName).freeze

            attr_accessor :payment_method, :status
            attr_reader :currency

            # Cursor for the next page of results
            attr_writer :next

            def currency=(value)
              @currency = value.to_s.empty? ? nil : value.to_s.upcase
            end

            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.root_key     = 'query'
              self.request_name = 'billingStatements'
              self.request_path = 'billing_statements'
            end

            # List of requested response fields
            def response_fields
              @response_fields || []
            end

            # Sets response fields validated against StatementResponseFields
            def response_fields=(value)
              parse_array_of_strings attribute: __method__,
                                     value: value,
                                     allowed: Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::
                                         StatementResponseFields.all
            end

            # Returns the creation date formatted as YYYY-MM-DD
            def creation_date
              @creation_date&.strftime(Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601)
            end

            # Sets the creation date filter
            def creation_date=(value)
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            protected

            # Adds response_fields to the list of required fields
            def init_field_validations
              super

              required_fields.push :response_fields
              field_values.merge! currency:      Api::Constants::Currencies::Iso4217.all.map(&:upcase),
                                  status:        STATUSES,
                                  sort_by_field: ORDER_BY_FIELDS
            end

            # Validates all request requirements including filters and date ranges
            def check_requirements
              super

              validate_filters
              validate_date_range(:start_date, :end_date, MAX_DAYS_DIFFERENCE) if @start_date || @end_date
              if @start_date_from || @start_date_to
                validate_date_range(:start_date_from, :start_date_to, MAX_DAYS_DIFFERENCE)
              end
              validate_date_range(:end_date_from, :end_date_to, MAX_DAYS_DIFFERENCE) if @end_date_from || @end_date_to
              validate_array_size :billing_statement, MAX_COUNT_BILLING_STATEMENT
            end

            # Builds the GraphQL query filters hash
            def query_filters # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
              filters = {
                startDate:        escape_argument(:start_date),
                endDate:          escape_argument(:end_date),
                startDateFrom:    escape_argument(:start_date_from),
                startDateTo:      escape_argument(:start_date_to),
                endDateFrom:      escape_argument(:end_date_from),
                endDateTo:        escape_argument(:end_date_to),
                billingStatement: billing_statement.empty? ? nil : billing_statement,
                currency:         escape_string(currency),
                status:           status,
                paymentMethod:    escape_string(payment_method),
                creationDate:     escape_string(creation_date)
              }

              { filter: filters, **paging_and_sort }
            end

            # Builds the GraphQL response fields structure including paging metadata
            def query_response_fields
              {
                items:  format_response_fields,
                paging: %w(count perPage after before)
              }
            end

            # Merges sort and cursor-based paging into a single hash, omitting empty values
            def paging_and_sort
              result = {}
              result[:sort]   = { byDirection: sort_by_direction, byField: sort_by_field }.compact
              result[:paging] = cursor_paging
              result.reject { |_, v| v.empty? }
            end

            # Builds the cursor-based paging hash
            def cursor_paging
              paging = {}
              paging[:perPage] = per_page if per_page
              paging[:next]    = "\"#{@next}\"" if @next
              paging
            end

            # Maps response field names to their expanded GraphQL representations
            def format_response_fields
              response_fields.map { |field| complex_field(field) }
            end

            # Expands summary and details fields into their full GraphQL sub-selections
            def complex_field(field)
              case field
              when 'summary'
                'summary { grossVolume debit credit fees taxes netReserves adjustments ' \
                  'netSettlementAmount paymentFxConversionFee paymentAmount paymentCurrency }'
              when 'details'
                'details { transactionTypesBreakdown { category transactionType count amount } }'
              else
                field
              end
            end

            # Raises an error when no filter attributes are set
            def validate_filters # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
              return unless start_date.nil? && end_date.nil? &&
                            start_date_from.nil? && start_date_to.nil? &&
                            end_date_from.nil? && end_date_to.nil? &&
                            billing_statement.empty? && currency.nil? &&
                            status.nil? && payment_method.nil? && creation_date.nil?

              raise ParameterError, 'At least one filter is required!'
            end

          end
        end
      end
    end
  end
end
