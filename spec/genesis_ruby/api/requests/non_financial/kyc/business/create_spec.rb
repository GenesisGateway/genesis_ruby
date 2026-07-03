# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Business::Create do
  let(:test_required_fields) do
    %i[registration_number country]
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

    request.registration_number = '123456789'
    request.country = 'GB'
    request.name = 'Company name'

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'businesses'
    end

    it 'with proper endpoint url' do
      request.build_document

      expect(request.api_config['url']).to eq 'https://staging.kyc.emerchantpay.net:443/api/v1/businesses'
    end

    it 'with proper request structure' do
      expect(request.build_document).to include '"registration_number": "123456789"'
    end

    it 'with optional name' do
      expect(request.build_document).to include '"name": "Company name"'
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
