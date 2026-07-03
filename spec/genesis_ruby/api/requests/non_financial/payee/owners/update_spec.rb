# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Owners::Update do
  let(:test_required_fields) { %i[owner_unique_id] }
  let(:config) do
    config = GenesisRuby::Configuration.new
    config.username = 'example_username'
    config.password = 'example_password'
    config.token = 'example_token'
    config.endpoint = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:sample_data) do
    {
      owner_unique_id:     SecureRandom.uuid,
      owner_name:          Faker::Company.name,
      owner_country:       GenesisRuby::Utils::Country::COUNTRIES.keys.sample,
      owner_date:          Faker::Date.backward(days: 365).to_s,
      notification_url:    Faker::Internet.url,
      registration_number: Faker::Alphanumeric.alphanumeric(number: 10),
      owner_address:       {
        first_line: Faker::Address.street_address,
        city:       Faker::Address.city,
        zip_code:   Faker::Address.zip_code
      }
    }
  end
  let(:request) do
    request = described_class.new config

    request.owner_unique_id = sample_data[:owner_unique_id]
    request.owner_name = sample_data[:owner_name]
    request.owner_country = sample_data[:owner_country]
    request.owner_date = sample_data[:owner_date]
    request.notification_url = sample_data[:notification_url]
    request.registration_number = sample_data[:registration_number]
    request.owner_address = sample_data[:owner_address]

    request
  end

  context 'when valid request' do
    it 'with proper request structure' do # rubocop:disable RSpec/ExampleLength,RSpec/MultipleExpectations
      parsed = JSON.parse(request.build_document)

      expect(parsed['owner']['name']).to eq sample_data[:owner_name]
      expect(parsed['owner']['country']).to eq sample_data[:owner_country]
      expect(parsed['owner']['date']).to eq sample_data[:owner_date]
      expect(parsed['owner']['notification_url']).to eq sample_data[:notification_url]
      expect(parsed['owner']['registration_number']).to eq sample_data[:registration_number]
    end

    it 'with proper endpoint url' do
      request.build_document

      expect(request.api_config['url']).to eq(
        "https://staging.api.emerchantpay.net:443/payee/owners/#{sample_data[:owner_unique_id]}"
      )
    end

    it 'with proper HTTP request type' do
      expect(request.api_config['type']).to eq 'PATCH'
    end

    it 'without token in configuration' do
      request.build_document

      expect(request.api_config['token']).to be_nil
    end

    it 'with minimum request data' do # rubocop:disable RSpec/ExampleLength
      request.owner_name = nil
      request.owner_country = nil
      request.owner_date = nil
      request.notification_url = nil
      request.registration_number = nil
      request.owner_address = nil
      expect { request.build_document }.to_not raise_error
    end
  end

  context 'when invalid request' do
    it 'with missing owner_unique_id should raise error' do
      request.owner_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with invalid owner_country should raise error' do
      request.owner_country = 'INVALID'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  context 'when processing request parameters' do
    it 'replaces placeholder in request path with actual owner_unique_id' do
      request.owner_unique_id = 'custom_owner_456'
      request.build_document

      expect(request.api_config['url']).to include('payee/owners/custom_owner_456')
    end
  end

  include_examples 'base request examples'
end
