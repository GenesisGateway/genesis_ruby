# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/non_financial/billing_api/statement_response_fields'
require 'genesis_ruby/api/constants/transactions/parameters/non_financial/billing_api/statement_order_by_fields'
require 'genesis_ruby/api/requests/base/non_financial/billing_api/abstract_statement'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module BillingApi
          # Billing Statements API request
          class Statement < Base::NonFinancial::BillingApi::AbstractStatement

            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.root_key     = 'query'
              self.request_name = 'billingStatements'
              self.request_path = 'billing_statements'
            end

            protected

            # GraphQL query name
            def request_name
              'billingStatements'
            end

            # Allowed top-level response fields for billingStatements
            def allowed_response_fields
              Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::StatementResponseFields
            end

            # Allowed order-by fields for billingStatements
            def allowed_order_by_fields
              Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::StatementOrderByFields
            end

          end
        end
      end
    end
  end
end
