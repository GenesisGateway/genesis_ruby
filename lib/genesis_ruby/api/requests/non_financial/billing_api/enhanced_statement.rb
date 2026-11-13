# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/non_financial/billing_api/' \
        'enhanced_statement_response_fields'
require 'genesis_ruby/api/constants/transactions/parameters/non_financial/billing_api/statement_order_by_fields'
require 'genesis_ruby/api/requests/base/non_financial/billing_api/abstract_statement'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module BillingApi
          # Enhanced Billing Statements API request
          class EnhancedStatement < Base::NonFinancial::BillingApi::AbstractStatement

            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.root_key     = 'query'
              self.request_name = 'enhancedBillingStatements'
              self.request_path = 'billing_statements'
            end

            protected

            # GraphQL query name targeted by the request
            def request_name
              'enhancedBillingStatements'
            end

            # Allowed top-level response fields (includes pricingMethod)
            def allowed_response_fields
              Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::EnhancedStatementResponseFields
            end

            # Allowed order-by fields (shared with the standard statement request)
            def allowed_order_by_fields
              Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::StatementOrderByFields
            end

          end
        end
      end
    end
  end
end
