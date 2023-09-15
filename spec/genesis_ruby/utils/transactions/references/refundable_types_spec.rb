require 'genesis_ruby/utils/transactions/references/refundable_types'
require 'spec/genesis_ruby/shared_examples/utils/transactions/types_examples'

RSpec.describe GenesisRuby::Utils::Transactions::References::RefundableTypes do

  include_examples 'types examples'

  it 'works with allowed reference type' do
    expect(described_class.allowed_reference?(GenesisRuby::Api::Constants::Transactions::SALE)).to eq(true)
  end

  it 'fails with not allowed reference type' do
    expect(described_class.allowed_reference?(GenesisRuby::Api::Constants::Transactions::AUTHORIZE)).to eq(false)
  end

  it 'woks when refund type' do
    expect(described_class.valid?(GenesisRuby::Api::Constants::Transactions::REFUND)).to eq(true)
  end

  it 'fails when not refund type' do
    expect(described_class.valid?(GenesisRuby::Api::Constants::Transactions::AUTHORIZE)).to eq(false)
  end

  it 'returns correct reference refund transaction type' do
    expect(
      described_class.fetch_reference(GenesisRuby::Api::Constants::Transactions::CAPTURE)
    ).to eq(GenesisRuby::Api::Constants::Transactions::REFUND)
  end
end
