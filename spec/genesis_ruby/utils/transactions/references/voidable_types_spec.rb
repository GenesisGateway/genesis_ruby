require 'genesis_ruby/utils/transactions/references/voidable_types'
require 'spec/genesis_ruby/shared_examples/utils/transactions/types_examples'

RSpec.describe GenesisRuby::Utils::Transactions::References::VoidableTypes do

  include_examples 'types examples'

  it 'works with allowed reference type' do
    expect(described_class.allowed_reference?(GenesisRuby::Api::Constants::Transactions::AUTHORIZE)).to eq(true)
  end

  it 'fails with not allowed reference type' do
    expect(described_class.allowed_reference?(GenesisRuby::Api::Constants::Transactions::UPI)).to eq(false)
  end

  it 'works when void type' do
    expect(described_class.valid?(GenesisRuby::Api::Constants::Transactions::VOID)).to eq(true)
  end

  it 'fails when not void type' do
    expect(described_class.valid?(GenesisRuby::Api::Constants::Transactions::AUTHORIZE)).to eq(false)
  end

  it 'returns correct reference void transaction type' do
    expect(described_class.fetch_reference('type')).to eq(GenesisRuby::Api::Constants::Transactions::VOID)
  end
end
