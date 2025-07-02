# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Installments::Fetch do
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

    request.amount      = 123
    request.currency    = 'GBP'
    request.card_number = '4200000000000000'

    request
  end

  it 'with proper request structure' do
    expect(request.build_document)
      .to eq "{\n  \"amount\": 123,\n  \"currency\": \"GBP\",\n  \"card_number\": \"4200000000000000\"\n}"
  end

  describe 'when amount' do
    it 'with valid value' do
      request.amount = 1

      expect(request.build_document).to include '"amount": 1'
    end

    it 'with invalid value' do
      expect { request.amount = '1' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when card_number' do
    it 'with valid number value' do
      request.card_number = 4_200_000_000_000_000

      expect(request.build_document).to include '"card_number": "4200000000000000"'
    end

    it 'with invalid value' do
      expect { request.card_number = Faker::Lorem.word }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when currency' do
    it 'with invalid value' do
      request.currency = 'AAA'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
