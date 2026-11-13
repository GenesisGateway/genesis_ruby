# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/non_financial/scopes'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module PaymentAuthorizations
          # Date range based Payment Authorizations retrieval allows you to fetch a paginated list of payment
          # authorizations created and/or authorized within a given date range.
          class DateRange < Api::Request

            include Api::Mixins::Requests::NonFinancial::DateAttributes
            include Api::Mixins::Requests::NonFinancial::PagingAttributes
            include Api::Mixins::Requests::NonFinancial::ScopeAttributes

            # Maximum allowed records per page
            MAX_PER_PAGE = 500

            # Start of the requested creation date range
            def start_date
              @start_date&.strftime Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
            end

            # End of the requested creation date range
            def end_date
              @end_date&.strftime Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
            end

            # Start of the requested authorization date range
            def auth_start_date
              @auth_start_date&.strftime Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
            end

            # Start of the requested authorization date range
            def auth_start_date=(value)
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            # End of the requested authorization date range
            def auth_end_date
              @auth_end_date&.strftime Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
            end

            # End of the requested authorization date range
            def auth_end_date=(value)
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            protected

            # Payment Authorizations API DateRange request configuration
            def init_configuration
              init_xml_configuration
              init_api_gateway_configuration request_path: 'payment_authorizations/by_date', include_token: false
              @api_config.parser_skip_root_node = false
            end

            # Payment Authorizations API DateRange field validations
            def init_field_validations
              super

              required_fields.push *%i[scope]
            end

            # Payment Authorizations API DateRange custom field validations
            def check_requirements
              validate_start_dates
              validate_range_order :start_date, :end_date
              validate_range_order :auth_start_date, :auth_end_date
              validate_per_page

              super
            end

            # Payment Authorizations API DateRange request structure
            def populate_structure # rubocop:disable Metrics/MethodLength
              @tree_structure = {
                payment_authorization_request: {
                  start_date:      start_date,
                  end_date:        end_date,
                  auth_start_date: auth_start_date,
                  auth_end_date:   auth_end_date,
                  page:            page,
                  per_page:        per_page,
                  scope:           scope
                }
              }
            end

            private

            # At least one of start_date or auth_start_date is required
            def validate_start_dates
              return unless @start_date.nil? && @auth_start_date.nil?

              raise ParameterError, 'At least one of start_date or auth_start_date fields has to be set.'
            end

            # End of a date range cannot be on an earlier calendar day than its start
            def validate_range_order(start_attribute, end_attribute)
              start_value = instance_variable_get "@#{start_attribute}"
              end_value   = instance_variable_get "@#{end_attribute}"

              return if start_value.nil? || end_value.nil?
              return if end_value.to_date >= start_value.to_date

              raise ParameterError, "#{start_attribute} cannot be later than #{end_attribute}."
            end

            # Per page cannot exceed the maximum allowed records
            def validate_per_page
              return if per_page.nil? || per_page <= MAX_PER_PAGE

              raise ParameterError, "per_page cannot be greater than #{MAX_PER_PAGE}."
            end

          end
        end
      end
    end
  end
end
