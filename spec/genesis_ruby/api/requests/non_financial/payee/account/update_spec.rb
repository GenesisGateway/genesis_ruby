# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Account::Update do
  let(:test_required_fields) { %i[payee_unique_id account_unique_id payee_account_country] }
  let(:config) do
    config = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:sample_data) do
    {
      payee_unique_id:       SecureRandom.uuid,
      account_unique_id:     SecureRandom.uuid,
      payee_account_country: GenesisRuby::Utils::Country::COUNTRIES.keys.sample
    }
  end
  let(:request) do
    request = described_class.new config

    request.payee_unique_id        = sample_data[:payee_unique_id]
    request.account_unique_id      = sample_data[:account_unique_id]
    request.payee_account_country  = sample_data[:payee_account_country]

    request
  end

  context 'when valid request' do
    it 'with proper request structure' do # rubocop:disable RSpec/ExampleLength
      expected_structure = {
        'account' => {
          'country' => sample_data[:payee_account_country]
        }
      }
      expect(JSON.parse(request.build_document)).to eq expected_structure
    end

    it 'with proper endpoint url' do
      request.build_document
      expect(request.api_config['url']).to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/account/#{sample_data[:account_unique_id]}"
    end

    it 'with proper HTTP request type' do
      expect(request.api_config['type']).to eq 'PATCH'
    end

    it 'without token in configuration' do
      request.build_document

      expect(request.api_config['token']).to be_nil
    end
  end

  context 'when invalid request' do
    it 'with missing payee_unique_id should raise error' do
      request.payee_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with invalid payee_country values should raise error' do
      request.payee_account_country = 'INVALID'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
