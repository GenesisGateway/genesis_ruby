# frozen_string_literal: true

require 'genesis_ruby/utils/transactions/references/capturable_types'
require 'spec/genesis_ruby/shared_examples/utils/transactions/types_examples'

RSpec.describe GenesisRuby::Utils::Transactions::References::CapturableTypes do

  include_examples 'types examples'

  it 'works with allowed reference type' do
    expect(described_class.allowed_reference?(GenesisRuby::Api::Constants::Transactions::AUTHORIZE)).to eq(true)
  end

  it 'fails with not allowed reference type' do
    expect(described_class.allowed_reference?(GenesisRuby::Api::Constants::Transactions::SALE)).to eq(false)
  end

  it 'woks when capture type' do
    expect(described_class.valid?(GenesisRuby::Api::Constants::Transactions::CAPTURE)).to eq(true)
  end

  it 'fails when not capture type' do
    expect(described_class.valid?(GenesisRuby::Api::Constants::Transactions::AUTHORIZE)).to eq(false)
  end

  it 'returns correct reference capture transaction type' do
    expect(
      described_class.fetch_reference(GenesisRuby::Api::Constants::Transactions::AUTHORIZE)
    ).to eq(GenesisRuby::Api::Constants::Transactions::CAPTURE)
  end
end
