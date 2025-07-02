# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Account::List do
  let(:test_required_fields) { %i[payee_unique_id] }
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
      payee_unique_id:     Faker::Internet.uuid,
      number_eq:           Faker::Bank.account_number,
      type_eq:             %w(iban bank).sample,
      institution_code_eq: Faker::Bank.swift_bic
    }
  end
  let(:request) do
    request = described_class.new config

    request.payee_unique_id     = sample_data[:payee_unique_id]
    request.number_eq           = sample_data[:number_eq]
    request.type_eq             = sample_data[:type_eq]
    request.institution_code_eq = sample_data[:institution_code_eq]

    request
  end

  it 'when building document with proper request structure' do
    expected_structure = {}

    expect(JSON.parse(request.build_document)).to eq expected_structure
  end

  context 'when valid request' do
    it 'when configured with proper endpoint url with all parameters' do # rubocop:disable RSpec/ExampleLength
      request.build_document

      query_params = URI.encode_www_form(
        {
          'number_eq'           => sample_data[:number_eq],
          'type_eq'             => sample_data[:type_eq],
          'institution_code_eq' => sample_data[:institution_code_eq]
        }
      )

      expect(request.api_config['url'])
        .to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/account?#{query_params}"
    end

    it 'when configured with proper endpoint url with only required parameters' do # rubocop:disable RSpec/ExampleLength
      request.number_eq           = nil
      request.type_eq             = nil
      request.institution_code_eq = nil

      request.build_document

      expect(request.api_config['url'])
        .to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/account"
    end

    it 'when using GET HTTP request type' do
      expect(request.api_config['type']).to eq 'GET'
    end

    it 'with all fields should not raise error' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with only required fields should not raise error' do
      request.number_eq           = nil
      request.type_eq             = nil
      request.institution_code_eq = nil

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
  end

  context 'when query parameters' do
    it 'with includes number_eq when provided' do # rubocop:disable RSpec/ExampleLength
      request.number_eq           = '123456'
      request.type_eq             = nil
      request.institution_code_eq = nil

      request.build_document

      expect(request.api_config['url'])
        .to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/account?number_eq=123456"
    end

    it 'includes type_eq when provided' do # rubocop:disable RSpec/ExampleLength
      request.number_eq           = nil
      request.type_eq             = 'iban'
      request.institution_code_eq = nil

      request.build_document

      expect(request.api_config['url'])
        .to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/account?type_eq=iban"
    end

    it 'includes institution_code_eq when provided' do # rubocop:disable RSpec/ExampleLength
      request.number_eq           = nil
      request.type_eq             = nil
      request.institution_code_eq = 'BNPAFRPP'

      request.build_document

      expect(request.api_config['url'])
        .to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/account?institution_code_eq=BNPAFRPP"
    end

    it 'combines multiple query parameters when provided' do # rubocop:disable RSpec/ExampleLength
      request.number_eq           = '123456'
      request.type_eq             = 'iban'
      request.institution_code_eq = nil

      request.build_document

      expect(request.api_config['url'])
        .to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/account?number_eq=123456&type_eq=iban"
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
