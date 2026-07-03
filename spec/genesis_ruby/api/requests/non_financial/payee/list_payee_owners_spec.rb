# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::ListPayeeOwners do
  let(:test_required_fields) { %i[payee_unique_id] }
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
      payee_unique_id: Faker::Internet.uuid,
      type:            %w(company person).sample
    }
  end
  let(:request) do
    request = described_class.new config

    request.payee_unique_id = sample_data[:payee_unique_id]
    request.type = sample_data[:type]

    request
  end

  it 'when building document with proper request structure' do
    expected_structure = {}

    expect(JSON.parse(request.build_document)).to eq expected_structure
  end

  context 'when valid request' do
    it 'when configured with proper endpoint url with all parameters' do
      request.build_document

      query_params = URI.encode_www_form({ 'type' => sample_data[:type] })

      expect(request.api_config['url']).to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/owners?#{query_params}"
    end

    it 'when configured with proper endpoint url with only required parameters' do
      request.type = nil

      request.build_document

      expect(request.api_config['url']).to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/owners"
    end

    it 'when using GET HTTP request type' do
      expect(request.api_config['type']).to eq 'GET'
    end

    it 'when configured without token in configuration' do
      request.build_document

      expect(request.api_config['token']).to be_nil
    end
  end

  context 'when invalid request' do
    it 'with missing payee_unique_id should raise error' do
      request.payee_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with empty payee_unique_id should raise error' do
      request.payee_unique_id = ''
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  context 'when query parameters' do
    it 'includes type when provided' do
      request.type = 'company'

      request.build_document

      expect(request.api_config['url']).to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/owners?type=company"
    end

    it 'excludes type when not provided' do
      request.type = nil

      request.build_document

      expect(request.api_config['url']).to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/owners"
    end
  end

  include_examples 'base request examples'
end
