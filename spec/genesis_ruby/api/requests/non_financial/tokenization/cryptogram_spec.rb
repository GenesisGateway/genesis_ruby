# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Tokenization::Cryptogram do
  let(:test_required_fields) do
    %i[consumer_id email token_type token transaction_reference]
  end
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

    request.consumer_id           = Faker::Internet.uuid[..9]
    request.email                 = Faker::Internet.email
    request.token_type            = Faker::Lorem.word
    request.token                 = Faker::Lorem.characters(number: 36)
    request.transaction_reference = Faker::Lorem.word

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url]).to eq 'https://staging.gate.emerchantpay.net:443/v1/cryptogram'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<cryptogram_request>'
    end
  end

  describe 'when transaction_reference' do
    it 'with value' do
      request.transaction_reference = value = Faker::Lorem.word

      expect(request.build_document).to include "<transaction_reference>#{value}</transaction_reference>"
    end
  end

  include_examples 'base request examples'
  include_examples 'token attributes examples'
  include_examples 'tokenization api attributes examples'
  include_examples 'versioned request examples'
end
