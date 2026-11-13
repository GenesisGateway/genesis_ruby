# frozen_string_literal: true

require 'date'
require 'genesis_ruby/api/constants/date_time_formats'
require 'genesis_ruby/api/constants/currencies/iso4217'
require 'genesis_ruby/api/requests/base/non_financial/billing_api/base'

module GenesisRuby
  module Api
    module Requests
      module Base
        module NonFinancial
          module BillingApi
            # Shared base for billingStatements and enhancedBillingStatements requests
            class AbstractStatement < NonFinancial::BillingApi::Base # rubocop:disable Metrics/ClassLength

              include Api::Mixins::Requests::NonFinancial::DateTimeFromToAttributes

              MAX_COUNT_BILLING_STATEMENT  = 1_000
              MAX_COUNT_MASTER_ACCOUNT_MID = 1_000
              MAX_DAYS_DIFFERENCE          = 7

              # Allowed values for the +status+ filter
              STATUSES = %w(open pending paid bounced).freeze

              attr_accessor :payment_method, :status
              attr_reader :currency

              # Cursor for the next page of results
              attr_writer :next

              # ISO 4217 currency code, stored upper-cased
              def currency=(value)
                @currency = value.to_s.empty? ? nil : value.to_s.upcase
              end

              # Returns the creation date formatted as YYYY-MM-DD
              def creation_date
                @creation_date&.strftime Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
              end

              # Sets the creation date filter
              def creation_date=(value)
                parse_date attribute: __method__, value: value, allow_empty: true
              end

              # List of master account MIDs (max 1000). Rendered as a quoted GraphQL list literal.
              def master_account_mid
                @master_account_mid || []
              end

              # Sets the list of master account MIDs
              def master_account_mid=(value)
                parse_array_of_strings attribute: __method__, value: value, allow_empty: true
              end

              # List of requested response fields
              def response_fields
                @response_fields || []
              end

              # Accepts flat names and/or single-pair Hash[name => nested selection]
              def response_fields=(value)
                validate_response_fields_structure value

                @response_fields = value
              end

              protected

              # Abstract: concrete request must define the GraphQL query name
              def request_name
                raise NoMethodError, "request_name isn't defined for #{self.class.name}"
              end

              # Abstract: concrete request must define the allowed top-level response fields
              def allowed_response_fields
                raise NoMethodError, "allowed_response_fields isn't defined for #{self.class.name}"
              end

              # Abstract: concrete request must define the allowed order-by fields
              def allowed_order_by_fields
                raise NoMethodError, "allowed_order_by_fields isn't defined for #{self.class.name}"
              end

              # Registers response_fields as required and merges allowed values
              def init_field_validations
                super

                required_fields.push :response_fields
                field_values.merge! currency:      Api::Constants::Currencies::Iso4217.all.map(&:upcase),
                                    status:        STATUSES,
                                    sort_by_field: allowed_order_by_fields.all
              end

              # Validates all request requirements including filters and date ranges
              def check_requirements
                super

                validate_filters
                validate_statement_date_ranges
                validate_array_size :billing_statement, MAX_COUNT_BILLING_STATEMENT
                validate_array_size :master_account_mid, MAX_COUNT_MASTER_ACCOUNT_MID
                validate_response_fields_allowed
              end

              # Declarative filter map; empty values are omitted by the builder
              def query_filters # rubocop:disable Metrics/MethodLength
                filters = {
                  startDateFrom:    start_date_from,
                  startDateTo:      start_date_to,
                  endDateFrom:      end_date_from,
                  endDateTo:        end_date_to,
                  billingStatement: billing_statement,
                  masterAccountMID: master_account_mid,
                  currency:         currency,
                  status:           status,
                  paymentMethod:    payment_method,
                  creationDate:     creation_date
                }

                { filter: filters, **paging_and_sort }
              end

              # Filters rendered without surrounding quotes
              def filters_without_quotes
                %w(billingStatement status masterAccountMID)
              end

              # Builds the GraphQL response fields structure including paging metadata
              def query_response_fields
                { items: response_fields, paging: %w(count perPage after before) }
              end

              private

              # Merges sort and cursor-based paging into a single hash, omitting empty values
              def paging_and_sort
                result          = {}
                result[:sort]   = { byDirection: sort_by_direction, byField: sort_by_field }.compact
                result[:paging] = cursor_paging
                result.reject { |_, v| v.respond_to?(:empty?) && v.empty? }
              end

              # Builds the cursor-based paging hash
              def cursor_paging
                paging           = {}
                paging[:perPage] = per_page if per_page
                paging[:next]    = @next if @next
                paging
              end

              # Assignment-time structural check for response_fields
              def validate_response_fields_structure(value)
                raise InvalidArgumentError, 'response_fields accepts only Array value.' unless value.is_a?(Array)

                value.each { |node| validate_selection_node node }
              end

              # Validates a single response-field node (flat name or single-key Hash)
              def validate_selection_node(node) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
                return if node.is_a?(String) || node.is_a?(Symbol)

                unless node.is_a?(Hash) && node.size == 1
                  raise InvalidArgumentError, 'response_fields entries must be a field name or a single-key Hash.'
                end

                sub = node.values.first
                if !sub.is_a?(Array) || sub.empty?
                  raise InvalidArgumentError, "Empty sub-selection for #{node.keys.first}."
                end

                sub.each { |child| validate_selection_node child }
              end

              # Applies Date_Range_Pair validation to both statement range pairs.
              # Each pair is validated only when at least one of its boundaries is set, so a
              # request filtering solely on non-date attributes (e.g. currency) is not forced
              # to supply a date pair; a single-boundary pair still raises (R2.1).
              def validate_statement_date_ranges
                if @start_date_from || @start_date_to
                  validate_date_range :start_date_from, :start_date_to, MAX_DAYS_DIFFERENCE, allow_equal: true
                end

                return unless @end_date_from || @end_date_to

                validate_date_range :end_date_from, :end_date_to, MAX_DAYS_DIFFERENCE, allow_equal: true
              end

              # Raises an error when no filter attributes are set
              def validate_filters
                return unless no_filter_set?

                raise ParameterError, 'At least one filter is required!'
              end

              # Determines whether no filter attribute has been set
              def no_filter_set? # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
                start_date_from.nil? && start_date_to.nil? &&
                  end_date_from.nil? && end_date_to.nil? &&
                  billing_statement.empty? && master_account_mid.empty? &&
                  currency.nil? && status.nil? &&
                  payment_method.nil? && creation_date.nil?
              end

              # Build-time allowed-set check on top-level names only (case-sensitive, exact)
              def validate_response_fields_allowed
                invalid = top_level_names(response_fields) - allowed_response_fields.all
                return if invalid.empty?

                raise ParameterError, "Invalid response fields: #{invalid.join(", ")}. " \
                                      "Allowed: #{allowed_response_fields.all.join(", ")}."
              end

              # Extracts the top-level field names from a response-field selection
              def top_level_names(selection)
                selection.map { |node| node.is_a?(Hash) ? node.keys.first.to_s : node.to_s }
              end

            end
          end
        end
      end
    end
  end
end
