# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/industry_types'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Kyc::IndustryTypes do

  include_examples 'common constants examples', described_class::RISK_VENDOR

end
