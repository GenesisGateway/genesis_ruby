# frozen_string_literal: true

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

  it 'works with e_wallet reference type' do
    expect(described_class.allowed_reference?(GenesisRuby::Api::Constants::Transactions::E_WALLET)).to eq(true)
  end

  it 'returns refund reference type for e_wallet' do
    expect(
      described_class.fetch_reference(GenesisRuby::Api::Constants::Transactions::E_WALLET)
    ).to eq(GenesisRuby::Api::Constants::Transactions::REFUND)
  end

  it 'works when async_refund type' do
    expect(described_class.valid?('async_refund')).to be(true)
  end

  it 'works when upper-case async_refund type' do
    expect(described_class.valid?('ASYNC_REFUND')).to be(true)
  end

  it 'works when symbol async_refund type' do
    expect(described_class.valid?(:async_refund)).to be(true)
  end

  it 'fails with async_refund reference type' do
    expect(described_class.allowed_reference?('async_refund')).to be(false)
  end

  it 'does not contain async_refund in the refundable types' do
    expect(described_class.all).to_not include(GenesisRuby::Api::Constants::Transactions::ASYNC_REFUND)
  end
end
