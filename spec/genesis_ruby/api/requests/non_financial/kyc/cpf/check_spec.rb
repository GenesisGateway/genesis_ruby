# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Cpf::Check do
  let(:test_required_fields) do
    %i[document_id]
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

    request.document_id = '1234567890'

    request
  end

  describe 'when valid request' do
    it 'with proper endpoint url' do
      request.build_document

      expect(request.api_config['url'])
        .to eq 'https://staging.kyc.emerchantpay.net:443/api/v1/cpf/1234567890'
    end

    it 'with proper request structure' do
      expect(request.build_document).to eq '{}'
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
