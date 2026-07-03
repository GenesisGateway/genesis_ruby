# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Owners::ListOwners do
  let(:test_required_fields) { %i[] }
  let(:config) do
    config = GenesisRuby::Configuration.new
    config.username = 'example_username'
    config.password = 'example_password'
    config.token = 'example_token'
    config.endpoint = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:request) do
    described_class.new config
  end

  it 'when building document with proper request structure' do
    expected_structure = {}

    expect(JSON.parse(request.build_document)).to eq expected_structure
  end

  it 'when configured with proper endpoint url' do
    request.build_document

    expect(request.api_config['url']).to eq 'https://staging.api.emerchantpay.net:443/payee/owners'
  end

  it 'when using GET HTTP request type' do
    expect(request.api_config['type']).to eq 'GET'
  end

  it 'when configured without token in configuration' do
    request.build_document

    expect(request.api_config['token']).to be_nil
  end

  it 'with valid parameters should not raise error' do
    expect { request.build_document }.to_not raise_error
  end

  include_examples 'base request examples'
end
