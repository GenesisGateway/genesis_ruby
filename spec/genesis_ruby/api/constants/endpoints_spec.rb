# frozen_string_literal: true

require 'genesis_ruby/api/constants/endpoints'

RSpec.describe GenesisRuby::Api::Constants::Endpoints do
  it 'has valid e-comprocessing endpoint' do
    expect(described_class::ECOMPROCESSING).to eq('e-comprocessing.net')
  end

  it 'has valid emerchantpay endpoint' do
    expect(described_class::EMERCHANTPAY).to eq('emerchantpay.net')
  end
end
