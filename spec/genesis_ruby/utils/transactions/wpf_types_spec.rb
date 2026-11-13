# frozen_string_literal: true

require 'genesis_ruby/utils/transactions/wpf_types'
require 'spec/genesis_ruby/shared_examples/utils/transactions/types_examples'

RSpec.describe GenesisRuby::Utils::Transactions::WpfTypes do

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

  it 'does not validate async_refund transaction type' do
    expect(described_class.valid?('async_refund')).to be(false)
  end

  it 'does not contain async_refund transaction type' do
    expect(described_class.all).to_not include(GenesisRuby::Api::Constants::Transactions::ASYNC_REFUND)
  end
end
