# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Fx::SearchRate do
  let(:test_required_fields) { %i[tier_id source_currency target_currency] }
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

    request.tier_id         = 123
    request.source_currency = 'EUR'
    request.target_currency = 'USD'

    request
  end

  it 'with proper request structure' do
    expect(request.build_document)
      .to eq "{\n  \"source_currency\": \"EUR\",\n  \"target_currency\": \"USD\"\n}"
  end

  it 'with proper endpoint url' do
    request.build_document

    expect(request.api_config['url'])
      .to eq 'https://staging.gate.emerchantpay.net:443/v1/fx/tiers/123/rates/search'
  end

  it 'with POST HTTP request type' do
    expect(request.api_config['type']).to eq 'POST'
  end

  describe 'when source_currency' do
    it 'with value' do
      expect(request.build_document).to include '"source_currency": "EUR"'
    end

    it 'with lower case value' do
      request.source_currency = 'eur'

      expect(request.build_document).to include '"source_currency": "EUR"'
    end

    it 'without value' do
      request.source_currency = ''

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when target_currency' do
    it 'with value' do
      expect(request.build_document).to include '"target_currency": "USD"'
    end

    it 'with lower case value' do
      request.target_currency = 'usd'

      expect(request.build_document).to include '"target_currency": "USD"'
    end

    it 'without value' do
      request.target_currency = ''

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
