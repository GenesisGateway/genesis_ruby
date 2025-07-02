# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/order_sources'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Kyc::OrderSources do

  include_examples 'common constants examples', described_class::ORDER_SOURCE_INTERNET

end
