# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Sca::Checker do
  let(:test_required_fields) { %i[card_number transaction_amount transaction_currency] }
  let(:test_required_field_values) { %i[transaction_currency recurring_type transaction_exemption] }
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
    request.card_number           = '4200000000000000'
    request.transaction_amount    = 1.99
    request.transaction_currency  = 'EUR'

    request
  end

  it 'with proper endpoint url' do
    expect(request.api_config[:url]).to eq 'https://staging.gate.emerchantpay.net:443/v1/sca/checker/example_token'
  end

  describe 'when card_number' do
    it 'with invalid minimum string length' do
      expect { request.card_number = 123 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid maximum string length' do
      expect { request.card_number = Faker::Number.number(digits: 17).to_i }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with string value' do
      request.card_number = Faker::Number.number(digits: 16).to_i

      expect(request.card_number).to be_kind_of String
    end

    it 'with document element' do
      expect(request.build_document).to include '"card_number": "4200000000000000"'
    end
  end

  describe 'when transaction_amount' do
    it 'with document element' do
      expect(request.build_document).to include '"transaction_amount": 199'
    end
  end

  describe 'when transaction_currency' do
    it 'with document element' do
      expect(request.build_document).to include '"transaction_currency": "EUR"'
    end
  end

  describe 'when mit' do
    it 'without mit attributes' do
      expect(request.build_document).to_not include 'mit'
    end

    it 'with invalid value' do
      expect { request.mit = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid value' do
      request.mit = true

      expect(request.build_document).to include '"mit": true'
    end
  end

  describe 'when recurring_type' do
    it 'without recurring_type attribute' do
      expect(request.build_document).to_not include 'recurring_type'
    end

    it 'with valid value' do
      request.recurring_type = type = %w(initial subsequent).sample

      expect(request.build_document).to include "\"recurring_type\": \"#{type}\""
    end
  end

  describe 'when transaction_exemption' do
    it 'without transaction_exemption attribute' do
      expect(request.build_document).to_not include 'transaction_exemption'
    end

    it 'with valid value' do
      request.transaction_exemption = exemption = GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::
          ScaExemptions.all.sample

      expect(request.build_document).to include "\"transaction_exemption\": \"#{exemption}\""
    end
  end

  include_examples 'base request examples'
  include_examples 'moto attributes examples'
  include_examples 'versioned request examples'
end
