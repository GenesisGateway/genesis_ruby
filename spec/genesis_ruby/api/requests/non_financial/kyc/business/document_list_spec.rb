# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Business::DocumentList do
  let(:test_required_fields) do
    %i[business_id]
  end

  let(:config) do
    config = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end

  let(:request) do
    request = described_class.new config

    request.business_id = '12345'

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'businesses/:business_id/documents'
    end

    it 'with proper endpoint url' do
      request.build_document

      expect(request.api_config['url']).to eq 'https://staging.kyc.emerchantpay.net:443/api/v1/businesses/12345/documents'
    end

    it 'with GET request type' do
      request.build_document

      expect(request.api_config['type']).to eq 'GET'
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
