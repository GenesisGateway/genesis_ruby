# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Update do
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
      payee_unique_id:           SecureRandom.uuid,
      payee_name:                Faker::Company.name,
      payee_country:             GenesisRuby::Utils::Country::COUNTRIES.keys.sample,
      payee_date:                '1990-01-01',
      payee_notification_url:    'https://example.com/notifications',
      payee_registration_number: '123456789',
      payee_address_city:        Faker::Address.city,
      payee_address_street:      Faker::Address.street_address,
      payee_address_state:       Faker::Address.state,
      payee_address_country:     GenesisRuby::Utils::Country::COUNTRIES.keys.sample,
      payee_address_zip_code:    Faker::Address.zip_code
    }
  end
  let(:request) do
    request = described_class.new config

    request.payee_unique_id           = sample_data[:payee_unique_id]
    request.payee_name                = sample_data[:payee_name]
    request.payee_country             = sample_data[:payee_country]
    request.payee_date                = sample_data[:payee_date]
    request.payee_notification_url    = sample_data[:payee_notification_url]
    request.payee_registration_number = sample_data[:payee_registration_number]
    request.payee_address_city        = sample_data[:payee_address_city]
    request.payee_address_street      = sample_data[:payee_address_street]
    request.payee_address_state       = sample_data[:payee_address_state]
    request.payee_address_country     = sample_data[:payee_address_country]
    request.payee_address_zip_code    = sample_data[:payee_address_zip_code]

    request
  end

  context 'when valid request' do
    it 'with proper request structure' do # rubocop:disable RSpec/ExampleLength
      expected_structure = {
        'payee' => {
          'name'                => sample_data[:payee_name],
          'country'             => sample_data[:payee_country],
          'date'                => sample_data[:payee_date],
          'notification_url'    => sample_data[:payee_notification_url],
          'registration_number' => sample_data[:payee_registration_number],
          'address'             => {
            'city'     => sample_data[:payee_address_city],
            'street'   => sample_data[:payee_address_street],
            'state'    => sample_data[:payee_address_state],
            'country'  => sample_data[:payee_address_country],
            'zip_code' => sample_data[:payee_address_zip_code]
          }
        }
      }
      expect(JSON.parse(request.build_document)).to eq expected_structure
    end

    it 'with proper endpoint url' do
      request.build_document

      expect(request.api_config['url'])
        .to eq "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}"
    end

    it 'with proper HTTP request type' do
      expect(request.api_config['type']).to eq 'PATCH'
    end

    it 'without token in configuration' do
      request.build_document

      expect(request.api_config['token']).to be_nil
    end

    it 'with minimum request data' do # rubocop:disable RSpec/ExampleLength
      request.payee_name                = nil
      request.payee_country             = nil
      request.payee_date                = nil
      request.payee_notification_url    = nil
      request.payee_registration_number = nil
      request.payee_address_city        = nil
      request.payee_address_street      = nil
      request.payee_address_state       = nil
      request.payee_address_country     = nil
      request.payee_address_zip_code    = nil
      expect { request.build_document }.to_not raise_error
    end
  end

  context 'when nested address serialization' do
    it 'with address fields serialized under nested address key' do # rubocop:disable RSpec/ExampleLength
      parsed = JSON.parse(request.build_document)

      expect(parsed['payee']['address']).to eq(
        'city'     => sample_data[:payee_address_city],
        'street'   => sample_data[:payee_address_street],
        'state'    => sample_data[:payee_address_state],
        'country'  => sample_data[:payee_address_country],
        'zip_code' => sample_data[:payee_address_zip_code]
      )
    end

    it 'without address when all address fields are nil' do # rubocop:disable RSpec/ExampleLength
      request.payee_address_city     = nil
      request.payee_address_street   = nil
      request.payee_address_state    = nil
      request.payee_address_country  = nil
      request.payee_address_zip_code = nil

      parsed = JSON.parse(request.build_document)
      expect(parsed['payee']).to_not have_key('address')
    end

    it 'without neighborhood field in address' do
      parsed = JSON.parse(request.build_document)
      expect(parsed['payee']['address']).to_not have_key('neighborhood')
    end
  end

  context 'when registration_number' do
    it 'with registration_number serialized in payee' do
      parsed = JSON.parse(request.build_document)
      expect(parsed['payee']['registration_number']).to eq sample_data[:payee_registration_number]
    end
  end

  context 'when invalid request' do
    it 'with missing payee_unique_id should raise error' do
      request.payee_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with invalid payee_country values should raise error' do
      request.payee_country = 'INVALID'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with invalid payee_address_country values should raise error' do
      request.payee_address_country = 'INVALID'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
