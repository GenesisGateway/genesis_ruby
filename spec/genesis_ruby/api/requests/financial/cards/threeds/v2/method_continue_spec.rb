RSpec.describe GenesisRuby::Api::Requests::Financial::Cards::Threeds::V2::MethodContinue do
  let(:test_required_fields) { %i[amount transaction_timestamp] }
  let(:timestamp) do
    Faker::Date.between(from: '1990-01-01', to: '2040-12-31')
               .strftime(GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S_ZULU)
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

    request.transaction_unique_id = Faker::Internet.uuid
    request.transaction_timestamp = timestamp
    request.amount = 99

    request
  end

  describe 'when attributes' do

    it 'with currency' do
      request.currency = currency =  'EUR'
      expect(request.currency).to eq currency
    end

    it 'with amount' do
      request.amount = amount = 0.99

      expect(request.amount).to eq amount
    end

    it 'with transaction_unique_id' do
      request.transaction_unique_id = unique_id = Faker::Internet.uuid

      expect(request.transaction_unique_id).to eq unique_id
    end

    it 'with url' do
      request.url = url = Faker::Internet.url

      expect(request.url).to eq url
    end

    it 'with signature' do
      request.signature = signature = Faker::Internet.uuid

      expect(request.signature).to eq signature
    end

    it 'with transaction_timestamp' do
      request.transaction_timestamp = timestamp

      expect(request.transaction_timestamp).to eq timestamp
    end
  end

  describe 'when build attributes' do

    it 'with url extracts unique_id' do
      uuid       = Faker::Internet.uuid
      request    = described_class.new config
      request.url = "https://example.com/#{uuid}"

      expect(request.transaction_unique_id).to eq uuid
    end

    it 'with proper amount to exponent conversion' do # rubocop:disable RSpec/ExampleLength
      uuid      = Faker::Internet.uuid

      request.amount                = 10.00
      request.currency              = 'EUR'
      request.transaction_timestamp = timestamp
      request.transaction_unique_id = uuid

      signature = GenesisRuby::Utils::Threeds::V2.generate_signature(
        unique_id: uuid, amount: 1000, timestamp: timestamp, merchant_password: config.password
      )

      expect(request.build_document).to include "signature=#{signature}"
    end

    it 'with proper signature generation' do # rubocop:disable RSpec/ExampleLength
      uuid     = Faker::Internet.uuid
      currency = 'EUR'

      request.transaction_unique_id = uuid
      request.amount                = 0.99
      request.currency              = currency
      request.transaction_timestamp = timestamp

      signature = Digest::SHA512.hexdigest "#{uuid}99#{timestamp}#{config.password}"

      expect(request.signature).to eq signature
    end

    it 'with proper endpoint url initialization' do
      expect(request.api_config.url).to eq 'https://staging.gate.emerchantpay.net:443/threeds/threeds_method/:unique_id'
    end

    it 'with proper endpoint url with unique_id' do
      request.transaction_unique_id = uuid = Faker::Internet.uuid

      request.build_document

      expect(request.api_config.url).to eq "https://staging.gate.emerchantpay.net:443/threeds/threeds_method/#{uuid}"
    end

    it 'with proper builder interface' do
      expect(request.api_config.format).to eq GenesisRuby::Builder::FORM
    end

    it 'with proper request method' do
      expect(request.api_config.type).to eq GenesisRuby::Api::Request::METHOD_PUT
    end

    it 'with defined url' do
      request.url = url = 'https://example.com/unique_id'

      request.build_document

      expect(request.api_config.url).to eq url
    end
  end

  describe 'when load from response' do
    let(:response) do
      {
        transaction_type:            'sale3d',
        status:                      'pending_async',
        unique_id:                   'cb855cc4ea7d752fdf181d817926a928',
        transaction_id:              '96007ac6-5582-4990-8553-1905c6c6715a',
        technical_message:           'TESTMODE: No real money will be transferred!',
        message:                     'TESTMODE: No real money will be transferred!',
        threeds_method_url:          'https://staging.gate.emerchantpay.net/threeds/threeds_method',
        threeds_method_continue_url: 'https://staging.gate.emerchantpay.net/threeds/threeds_method/cb855cc4ea7d752fdf181d817926a928',
        mode:                        'test',
        timestamp:                   DateTime.new,
        descriptor:                  'test',
        amount:                      '0.99',
        currency:                    'EUR',
        sent_to_acquirer:            'false'
      }
    end

    it 'with empty response object' do
      expect { described_class.build_from_response_object(config, {}) }
        .to raise_error(GenesisRuby::ParameterError)
    end

    it 'with response object' do
      genesis = described_class.build_from_response_object(config, response)

      expect(genesis).to be_kind_of GenesisRuby::Genesis
    end

  end

  include_examples 'base request examples'
end
