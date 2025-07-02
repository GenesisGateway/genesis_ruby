# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Retrieve do
  let(:test_required_fields) { %i[payee_unique_id] }
  let(:payee_unique_id) { Faker::Internet.uuid }
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
    request                 = described_class.new config
    request.payee_unique_id = payee_unique_id

    request
  end

  it 'when building document with proper request structure' do
    expected_structure = {}

    expect(JSON.parse(request.build_document)).to eq expected_structure
  end

  it 'when configured with proper endpoint url' do
    request.build_document

    expect(request.api_config['url'])
      .to eq "https://staging.api.emerchantpay.net:443/payee/#{payee_unique_id}"
  end

  it 'when using GET HTTP request type' do
    expect(request.api_config['type']).to eq 'GET'
  end

  it 'when configured without token in configuration' do
    request.build_document

    expect(request.api_config['token']).to be_nil
  end

  context 'when validating fields' do
    it 'with missing payee_unique_id should raise error' do
      request.payee_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with empty payee_unique_id should raise error' do
      request.payee_unique_id = ''
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with valid payee_unique_id should not raise error' do
      request.payee_unique_id = 'valid_payee_id'
      expect { request.build_document }.to_not raise_error
    end
  end

  context 'when processing request parameters' do
    it 'replaces placeholder in request path with actual payee_unique_id' do
      request.payee_unique_id = 'custom_payee_456'
      request.build_document

      expect(request.api_config['url']).to include('payee/custom_payee_456')
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
