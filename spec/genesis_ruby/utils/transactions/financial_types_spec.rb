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

  it 'validates e_wallet transaction type' do
    expect(described_class.valid?('e_wallet')).to be(true)
  end

  it 'validates async_refund transaction type' do
    expect(described_class.valid?('async_refund')).to be(true)
  end

  it 'validates upper-case async_refund transaction type' do
    expect(described_class.valid?('ASYNC_REFUND')).to be(true)
  end

  it 'validates symbol async_refund transaction type' do
    expect(described_class.valid?(:async_refund)).to be(true)
  end

  it 'contains async_refund transaction type exactly once' do
    expect(described_class.all.count(GenesisRuby::Api::Constants::Transactions::ASYNC_REFUND)).to eq(1)
  end
end
