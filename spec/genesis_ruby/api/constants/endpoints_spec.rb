require 'genesis_ruby/api/constants/endpoints'

RSpec.describe GenesisRuby::Api::Constants::Endpoints do
  it 'has valid e-comprocessing endpoint' do
    expect(GenesisRuby::Api::Constants::Endpoints::ECOMPROCESSING).to eq('e-comprocessing.net')
  end

  it 'has valid emerchantpay endpoint' do
    expect(GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY).to eq('emerchantpay.net')
  end
end
