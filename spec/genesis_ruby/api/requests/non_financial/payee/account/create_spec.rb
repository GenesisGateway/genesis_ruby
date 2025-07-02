# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Account::Create do
  let(:test_required_fields) { %i[payee_unique_id payee_account_type payee_account_number] }
  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:sample_data) do
    {
      payee_unique_id:                Faker::Internet.uuid,
      payee_account_type:             %w(iban bank).sample,
      payee_account_number:           Faker::Bank.account_number,
      payee_account_country:          GenesisRuby::Utils::Country::COUNTRIES.keys.sample,
      payee_account_institution_code: Faker::Bank.swift_bic
    }
  end
  let(:request) do
    request = described_class.new config

    request.payee_unique_id                = sample_data[:payee_unique_id]
    request.payee_account_type             = sample_data[:payee_account_type]
    request.payee_account_number           = sample_data[:payee_account_number]
    request.payee_account_country          = sample_data[:payee_account_country]
    request.payee_account_institution_code = sample_data[:payee_account_institution_code]

    request
  end

  it 'when building document with proper request structure' do # rubocop:disable RSpec/ExampleLength
    expected_structure = {
      'account' => {
        'type'             => sample_data[:payee_account_type],
        'number'           => sample_data[:payee_account_number],
        'country'          => sample_data[:payee_account_country],
        'institution_code' => sample_data[:payee_account_institution_code]
      }
    }

    expect(JSON.parse(request.build_document)).to eq expected_structure
  end

  context 'when valid request' do
    it 'when configured with proper endpoint url' do
      request.build_document

      expect(request.api_config['url'])
        .to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/account"
    end

    it 'when using POST HTTP request type' do
      expect(request.api_config['type']).to eq 'POST'
    end

    it 'with all fields should not raise error' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with minimum required fields' do
      request.payee_account_type             = 'iban'
      request.payee_account_number           = Faker::Bank.iban
      request.payee_account_country          = nil
      request.payee_account_institution_code = nil

      expect { request.build_document }.to_not raise_error
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

    it 'with payee_account_type iban and missing payee_account_institution_code' do
      request.payee_account_type             = 'bank'
      request.payee_account_institution_code = nil

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
