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
              include Api::Mixins::Requests::NonFinancial::DateAttributes
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

              # Additional optional filter arguments (sort + paging)
              def additional_arguments
                [request_order, request_paging].reject(&:empty?).join(' ')
              end

              # Validate max size of an array attribute
              def validate_array_size(attribute, size)
                return if __send__(attribute).length <= size

                raise ParameterError,
                      format('Max array length on %{attribute} exceed allowed size of %{size}',
                             attribute: attribute, size: size)
              end

              # Validate a pair of date attributes: both required, from < to
              def validate_date_range(from_attr, to_attr, max_days_difference = 7)
                from_val = instance_variable_get("@#{from_attr}")
                to_val   = instance_variable_get("@#{to_attr}")
                message  = "If filter #{from_attr} is provided, then #{to_attr} should also be provided and vice versa."

                raise ParameterError, message unless from_val.is_a?(DateTime) && to_val.is_a?(DateTime)
                raise ParameterError, "#{to_attr} must be after #{from_attr}!" if from_val >= to_val

                days_diff = to_val - from_val
                return unless days_diff > max_days_difference

                raise ParameterError, "Maximum difference between date range is #{max_days_difference} days"
              end

              # Wraps a date attribute value in GraphQL double-quotes, or returns nil if blank
              def escape_argument(attribute)
                val = __send__(attribute)
                val.to_s.empty? ? nil : "\"#{val}\""
              end

              # Wraps a string value in GraphQL double-quotes, or returns nil if blank
              def escape_string(val)
                val.to_s.empty? ? nil : "\"#{val}\""
              end

              private

              # Generate the paging part of the GraphQL query
              def request_paging
                paging = {}
                paging[:page]    = page if page
                paging[:perPage] = per_page if per_page
                generate_graphql_code(paging, 'paging')
              end

              # Generate the sort/order part of the GraphQL query
              def request_order
                elements = {}
                elements[:byDirection] = sort_by_direction if sort_by_direction
                elements[:byField]     = sort_by_field if sort_by_field
                generate_graphql_code(elements, 'sort')
              end

              # Render a GraphQL inline argument block: key { k: v ... }
              def generate_graphql_code(hash, key)
                return '' if hash.empty?

                pairs = hash.map { |param, value| "#{param}: #{value.inspect}" }.join(', ')
                "#{key} { #{pairs} }"
              end

            end
          end
        end
      end
    end
  end
end
