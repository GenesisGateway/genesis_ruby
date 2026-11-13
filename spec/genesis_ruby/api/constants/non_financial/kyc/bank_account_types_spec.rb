# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/bank_account_types'

RSpec.describe GenesisRuby::Api::Constants::NonFinancial::Kyc::BankAccountTypes do

  include_examples 'common constants examples', described_class::BUSINESS

end
