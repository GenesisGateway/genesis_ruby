# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/non_financial/billing_api/order_by_fields'
require 'genesis_ruby/api/constants/transactions/parameters/non_financial/sort_directions'

module GenesisRuby
  module Api
    module Requests
      module Base
        module NonFinancial
          module BillingApi
            # Base class for Billing API GraphQL requests
            class Base < Requests::Base::Graphql

              include Api::Mixins::Requests::NonFinancial::BillingApi::SortAttributes
              include Api::Mixins::Requests::NonFinancial::PagingAttributes

              # List of billing statement names
              def billing_statement
                @billing_statement || []
              end

              # List of billing statement names
              def billing_statement=(value)
                parse_array_of_strings attribute: __method__, value: value, allow_empty: true
              end

              protected

              # Billing API Authorization Token
              def init_authorization_token
                api_config.bearer_token = configuration.billing_api_token
              end

              # Validate max size of an array attribute
              def validate_array_size(attribute, size)
                return if __send__(attribute).length <= size

                raise ParameterError,
                      format('Max array length on %{attribute} exceed allowed size of %{size}',
                             attribute: attribute, size: size)
              end

              # Validate a pair of date attributes: both required, from before/equal to.
              # When allow_equal is false (default) a zero-length span raises; strict pairs
              # (e.g. Transactions startDate/endDate) keep the historical from < to behaviour.
              # When allow_equal is true a zero-length span (from == to) and an exactly
              # max_days_difference span are accepted (statement range pairs, R2.3/R2.4).
              def validate_date_range(from_attr, to_attr, max_days_difference = 7, allow_equal: false)
                from_val = instance_variable_get("@#{from_attr}")
                to_val   = instance_variable_get("@#{to_attr}")
                message  = "If filter #{from_attr} is provided, then #{to_attr} should also be provided and vice versa."

                raise ParameterError, message unless from_val.is_a?(DateTime) && to_val.is_a?(DateTime)

                validate_date_order from_attr, to_attr, from_val, to_val, allow_equal

                days_diff = to_val - from_val
                return unless days_diff > max_days_difference

                raise ParameterError, "Maximum difference between date range is #{max_days_difference} days"
              end

              # Enforce chronological order for a date pair, honouring allow_equal
              def validate_date_order(from_attr, to_attr, from_val, to_val, allow_equal)
                return if allow_equal ? from_val <= to_val : from_val < to_val

                message = if allow_equal
                            "#{from_attr} must not be later than #{to_attr}!"
                          else
                            "#{to_attr} must be after #{from_attr}!"
                          end

                raise ParameterError, message
              end

              # GraphQL string escape table. Backslash MUST stay first so the backslashes
              # introduced by the other sequences are not escaped a second time.
              GRAPHQL_STRING_ESCAPES = {
                '\\' => '\\\\',
                '"'  => '\\"',
                "\n" => '\\n',
                "\r" => '\\r',
                "\t" => '\\t',
                "\b" => '\\b',
                "\f" => '\\f'
              }.freeze

              # Escape a scalar for embedding inside GraphQL double quotes.
              # Escapes backslash, double-quote and the five control characters in a single
              # left-to-right pass so a raw \" becomes \\\" without double-escaping.
              def escape_graphql_string(value)
                value.to_s.gsub(/[\\"\n\r\t\b\f]/, GRAPHQL_STRING_ESCAPES)
              end

              # Render an Array of strings as a GraphQL list literal: ["a","b"]
              # Each element is individually escaped and double-quoted, comma-separated, no whitespace.
              def format_string_list(values)
                inner = values.map { |value| %("#{escape_graphql_string(value)}") }.join(',')

                "[#{inner}]"
              end

            end
          end
        end
      end
    end
  end
end
