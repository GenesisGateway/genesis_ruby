# frozen_string_literal: true

require 'genesis_ruby/utils/transactions/financial_types'
require 'spec/genesis_ruby/shared_examples/utils/transactions/types_examples'

RSpec.describe GenesisRuby::Utils::Transactions::FinancialTypes do

  include_examples 'types examples'

  it 'validates with valid transaction type' do
    expect(described_class.valid?('authorize')).to be(true)
  end

  it 'validates with invalid transaction type' do
    expect(described_class.valid?('invalid')).to be(false)
  end
end
