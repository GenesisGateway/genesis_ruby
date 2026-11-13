# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/non_financial/billing_api/' \
        'enhanced_statement_response_fields'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::BillingApi::
  EnhancedStatementResponseFields do

  include_examples 'common constants examples', 'pricingMethod'

end
