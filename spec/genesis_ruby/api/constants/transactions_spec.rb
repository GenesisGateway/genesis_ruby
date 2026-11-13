# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Constants::Transactions do
  it 'includes common constants mixin' do
    expect(described_class.singleton_class.include?(GenesisRuby::Api::Mixins::Constants::Common)).to eq(true)
  end

  it 'has e_wallet transaction type' do
    expect(described_class::E_WALLET).to eq 'e_wallet'
  end

  it 'has async_refund transaction type' do
    expect(described_class::ASYNC_REFUND).to eq 'async_refund'
  end
end
