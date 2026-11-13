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

  it 'fails with async_refund reference type' do
    expect(described_class.allowed_reference?('async_refund')).to be(false)
  end

  it 'fails when async_refund type' do
    expect(described_class.valid?('async_refund')).to be(false)
  end

  it 'does not contain async_refund in the capturable types' do
    expect(described_class.all).to_not include(GenesisRuby::Api::Constants::Transactions::ASYNC_REFUND)
  end
end
