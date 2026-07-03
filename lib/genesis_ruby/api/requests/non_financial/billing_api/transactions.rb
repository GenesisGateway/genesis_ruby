# frozen_string_literal: true

require 'date'
require 'genesis_ruby/api/constants/transactions/parameters/non_financial/billing_api/order_by_fields'
require 'genesis_ruby/api/constants/transactions/parameters/non_financial/billing_api/response_fields'
require 'genesis_ruby/api/constants/transactions/parameters/non_financial/billing_api/transaction_types'
require 'genesis_ruby/api/constants/transactions/parameters/non_financial/sort_directions'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module BillingApi
          # Billing Transactions API allows to programmatically retrieve information about billing transactions
          # using given filters, pagination, and sort parameters.
          class Transactions < Base::NonFinancial::BillingApi::Base # rubocop:disable Metrics/ClassLength

            MAX_UNIQUE_ID_COUNT              = 1_000
            MAX_BILLING_STATEMENT_COUNT      = 10
            MAX_MERCHANT_TRANSACTION_COUNT   = 1_000
            MAX_MASTER_ACCOUNT_NAME_COUNT    = 10
            MAX_TRANSACTION_TYPE_COUNT       = 10
            MAX_DAYS_DIFFERENCE              = 7

            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.root_key     = 'query'
              self.request_name = 'billingTransactions'
              self.request_path = 'billing_transactions'
            end

            # Response Fields
            def response_fields
              @response_fields || []
            end

            # Response Fields
            def response_fields=(value)
              parse_array_of_strings attribute: __method__,
                                     value: value,
                                     allowed: Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::
                                         ResponseFields.all
            end

            # List of billing transaction unique IDs. Max number of elements is 1000. Primary filter.
            def unique_id
              @unique_id || []
            end

            # List of billing transaction unique IDs. Max number of elements is 1000. Primary filter.
            def unique_id=(value)
              parse_array_of_strings attribute: __method__, value: value, allow_empty: true
            end

            # List of merchant transaction IDs. Max number of elements allowed is 1000. Primary filter.
            def merchant_transaction_id
              @merchant_transaction_id || []
            end

            # List of merchant transaction IDs. Max number of elements allowed is 1000. Primary filter.
            def merchant_transaction_id=(value)
              parse_array_of_strings attribute: __method__, value: value, allow_empty: true
            end

            # List of master account names. Max number of elements allowed is 10. Secondary filter.
            def master_account_name
              @master_account_name || []
            end

            # List of master account names. Max number of elements allowed is 10. Secondary filter.
            def master_account_name=(value)
              parse_array_of_strings attribute: __method__, value: value, allow_empty: true
            end

            # List of billing transaction types. Max number of elements allowed is 10.
            def transaction_type
              @transaction_type || []
            end

            # List of billing transaction types. Max number of elements allowed is 10.
            def transaction_type=(value)
              parse_array_of_strings attribute: __method__,
                                     value: value,
                                     allowed: Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::
                                         TransactionTypes.all,
                                     allow_empty: true
            end

            protected

            # Billing API Transactions field validations
            def init_field_validations
              super

              required_fields.push :response_fields
              field_values.merge! sort_by_direction: Api::Constants::Transactions::Parameters::NonFinancial::
                                      SortDirections.all,
                                  sort_by_field: Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::
                                      OrderByFields.all
            end

            # Billing API Transactions custom validations
            def check_requirements
              super

              validate_filters
              validate_date_range(:start_date, :end_date, MAX_DAYS_DIFFERENCE) if @start_date || @end_date
              validate_array_fields_size
            end

            # Transactions GraphQL query filters
            def query_filters # rubocop:disable Metrics/MethodLength
              {
                filter: {
                  startDate:             escape_argument(:start_date),
                  endDate:               escape_argument(:end_date),
                  uniqueId:              unique_id,
                  billingStatement:      billing_statement,
                  merchantTransactionId: merchant_transaction_id,
                  masterAccountName:     master_account_name,
                  transactionType:       transaction_type
                },
                sort:   {
                  byDirection: sort_by_direction,
                  byField:     sort_by_field
                },
                paging: {
                  page:    page,
                  perPage: per_page
                }
              }
            end

            # Transactions Response Fields
            def query_response_fields
              {
                items:  response_fields,
                paging: paging_query_fields
              }
            end

            # Validate Billing API Primary filters
            def validate_filters
              return unless start_date.nil? && end_date.nil? && unique_id.empty? && billing_statement.empty? &&
                            merchant_transaction_id.empty?

              raise ParameterError, 'At least one Primary filter is required!'
            end

            # Validate Billing API Array field requirements
            def validate_array_fields_size
              validate_array_size :unique_id, MAX_UNIQUE_ID_COUNT
              validate_array_size :billing_statement, MAX_BILLING_STATEMENT_COUNT
              validate_array_size :merchant_transaction_id, MAX_MERCHANT_TRANSACTION_COUNT
              validate_array_size :master_account_name, MAX_MASTER_ACCOUNT_NAME_COUNT
              validate_array_size :transaction_type, MAX_TRANSACTION_TYPE_COUNT
            end

          end
        end
      end
    end
  end
end
