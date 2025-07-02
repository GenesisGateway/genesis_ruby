# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/african_mobile_operators'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::AfricanMobileOperators do
  include_examples 'common constants examples', described_class::SAFARICOM

  it 'with sale operators' do
    expect(described_class.sale).to be_kind_of Array
  end

end
