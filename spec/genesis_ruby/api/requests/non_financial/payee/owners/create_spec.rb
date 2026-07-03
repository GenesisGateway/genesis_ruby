# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Owners::Create do
  let(:test_required_fields) { %i[owner_type owner_name owner_country] }
  let(:test_required_field_values) { %i[owner_type owner_country] }
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
      owner_type:          GenesisRuby::Api::Constants::NonFinancial::Payee::OwnerTypes.all.sample,
      owner_name:          Faker::Company.name,
      owner_country:       GenesisRuby::Utils::Country::COUNTRIES.keys.sample,
      owner_date:          Faker::Date.backward(days: 365).to_s,
      notification_url:    Faker::Internet.url,
      registration_number: Faker::Alphanumeric.alphanumeric(number: 10),
      owner_address:       {
        first_line:  Faker::Address.street_address,
        second_line: Faker::Address.secondary_address,
        city:        Faker::Address.city,
        zip_code:    Faker::Address.zip_code,
        state:       Faker::Address.state
      },
      payees:              [{ unique_id: SecureRandom.uuid, percent_ownership: rand(1..100) }],
      owners:              [{ unique_id: SecureRandom.uuid, percent_ownership: rand(1..100) }]
    }
  end
  let(:request) do
    request = described_class.new config

    request.owner_type = sample_data[:owner_type]
    request.owner_name = sample_data[:owner_name]
    request.owner_country = sample_data[:owner_country]
    request.owner_date = sample_data[:owner_date]
    request.notification_url = sample_data[:notification_url]
    request.registration_number = sample_data[:registration_number]
    request.owner_address = sample_data[:owner_address]
    request.payees = sample_data[:payees]
    request.owners = sample_data[:owners]

    request
  end

  it 'when building document with proper request structure' do # rubocop:disable RSpec/ExampleLength,RSpec/MultipleExpectations
    parsed = JSON.parse(request.build_document)

    expect(parsed['owner']['type']).to eq sample_data[:owner_type]
    expect(parsed['owner']['name']).to eq sample_data[:owner_name]
    expect(parsed['owner']['country']).to eq sample_data[:owner_country]
    expect(parsed['owner']['date']).to eq sample_data[:owner_date]
    expect(parsed['owner']['notification_url']).to eq sample_data[:notification_url]
    expect(parsed['owner']['registration_number']).to eq sample_data[:registration_number]
  end

  it 'when configured with proper endpoint url' do
    request.build_document

    expect(request.api_config['url']).to eq 'https://staging.api.emerchantpay.net:443/payee/owners'
  end

  it 'when using POST HTTP request type' do
    expect(request.api_config['type']).to eq 'POST'
  end

  it 'when configured without token in configuration' do
    request.build_document

    expect(request.api_config['token']).to be_nil
  end

  context 'when validating fields' do
    it 'with missing owner_type should raise error' do
      request.owner_type = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with missing owner_name should raise error' do
      request.owner_name = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with missing owner_country should raise error' do
      request.owner_country = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with invalid owner_type should raise error' do
      request.owner_type = 'invalid_type'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with invalid owner_country should raise error' do
      request.owner_country = 'INVALID'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with valid parameters should not raise error' do
      expect { request.build_document }.to_not raise_error
    end
  end

  include_examples 'base request examples'
end
