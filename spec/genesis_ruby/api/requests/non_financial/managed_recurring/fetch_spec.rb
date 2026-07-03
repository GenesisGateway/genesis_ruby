# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::ManagedRecurring::Fetch do
  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:request) do
    request = described_class.new config

    request.unique_id = '12345'

    request
  end

  it 'with proper request structure' do
    expect(request.build_document).to eq '{}'
  end

  it 'with proper endpoint url' do
    request.build_document

    expect(request.api_config['url']).to eq 'https://staging.gate.emerchantpay.net:443/v1/managed_recurring/items/12345'
  end

  it 'with string unique_id' do
    request.unique_id = 1

    expect(request.unique_id).to be_kind_of String
  end

  it 'with GET HTTP request type' do
    expect(request.api_config['type']).to eq 'GET'
  end

  it 'with required unique_id validation' do
    request = described_class.new config

    expect { request.build_document }.to raise_error GenesisRuby::ParameterError
  end

  describe 'Unique ID path interpolation' do
    let(:unique_id) { 'test-unique-id-123' }

    it 'uses the unique_id in the endpoint URL' do
      request.unique_id = unique_id
      request.build_document
      expect(request.api_config['url']).to end_with "/managed_recurring/items/#{unique_id}"
    end
  end

  describe 'Empty unique_id rejection' do
    it 'with empty string unique_id raises error' do
      request = described_class.new config
      request.unique_id = ''

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
