# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Verifications::RetrievePayeeVerification do
  let(:test_required_fields) { %i[payee_unique_id verification_unique_id] }
  let(:config) do
    config = GenesisRuby::Configuration.new
    config.username = 'example_username'
    config.password = 'example_password'
    config.token = 'example_token'
    config.endpoint = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:sample_data) do
    {
      payee_unique_id:        Faker::Internet.uuid,
      verification_unique_id: Faker::Internet.uuid
    }
  end
  let(:request) do
    request = described_class.new config

    request.payee_unique_id = sample_data[:payee_unique_id]
    request.verification_unique_id = sample_data[:verification_unique_id]

    request
  end

  it 'when building document with proper request structure' do
    expected_structure = {}

    expect(JSON.parse(request.build_document)).to eq expected_structure
  end

  it 'when configured with proper endpoint url' do
    request.build_document

    expect(request.api_config['url']).to eq(
      "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/verifications/#{sample_data[:verification_unique_id]}"
    )
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

    it 'with missing verification_unique_id should raise error' do
      request.verification_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with empty payee_unique_id should raise error' do
      request.payee_unique_id = ''
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with valid parameters should not raise error' do
      expect { request.build_document }.to_not raise_error
    end
  end

  context 'when processing request parameters' do
    it 'replaces placeholders in request path with actual values' do
      request.payee_unique_id = 'custom_payee_123'
      request.verification_unique_id = 'custom_ver_456'
      request.build_document

      expect(request.api_config['url']).to include('payee/custom_payee_123/verifications/custom_ver_456')
    end
  end

  include_examples 'base request examples'
end
