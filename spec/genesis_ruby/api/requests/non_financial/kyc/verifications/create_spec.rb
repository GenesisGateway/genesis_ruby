# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Verifications::Create do
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
    request = described_class.new(config)

    request.email = Faker::Internet.email

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'verifications'
    end

    it 'with all required attributes' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with all attributes' do # rubocop:disable RSpec/ExampleLength
      request.country                         = GenesisRuby::Utils::Country::COUNTRIES.keys.sample
      request.language                        =
        GenesisRuby::Api::Constants::NonFinancial::Kyc::Languages.all.sample
      request.redirect_url                    = Faker::Internet.url
      request.reference_id                    = Faker::Number.number(digits: 10)
      request.document_supported_types        =
        GenesisRuby::Api::Constants::NonFinancial::Kyc::DocumentSupportedTypes.all.sample(2)
      request.address_supported_types         =
        GenesisRuby::Api::Constants::NonFinancial::Kyc::AddressSupportedTypes.all.sample(2)
      request.face_allow_offline              = Faker::Boolean.boolean
      request.face_allow_online               = Faker::Boolean.boolean
      request.face_check_duplicate_request    = Faker::Boolean.boolean
      request.backside_proof_required         = Faker::Boolean.boolean
      request.address_backside_proof_required = Faker::Boolean.boolean
      request.expiry_date                     = Faker::Date.forward(days: 100).strftime('%Y-%m-%d')
      request.allow_retry                     = Faker::Boolean.boolean
      request.verification_mode               =
        GenesisRuby::Api::Constants::NonFinancial::Kyc::VerificationModes.all.sample
      request.background_checks_first_name    = Faker::Name.first_name
      request.background_checks_middle_name   = Faker::Name.middle_name
      request.background_checks_last_name     = Faker::Name.last_name
      request.background_checks_full_name     = Faker::Name.name
      request.background_checks_date_of_birth =
        Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y-%m-%d')
      request.background_checks_async_update  = Faker::Boolean.boolean
      request.background_checks_filters       =
        GenesisRuby::Api::Constants::NonFinancial::Kyc::AmlFilters.all.sample(2)
      request.background_checks_match_score   = Faker::Number.number(digits: 2)
      request.document_first_name             = Faker::Name.first_name
      request.document_last_name              = Faker::Name.last_name
      request.document_date_of_birth          =
        Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y-%m-%d')
      request.document_allow_offline          = Faker::Boolean.boolean
      request.document_allow_online           = Faker::Boolean.boolean

      expect { request.build_document }.to_not raise_error
    end
  end

  describe 'when invalid request' do
    it 'with missing required attributes' do
      expect { request.email = nil }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid verification_mode' do
      request.verification_mode = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid address_backside_proof_required' do
      request.address_backside_proof_required = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid redirect_url' do
      expect { request.redirect_url = 'invalid' }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid language code' do
      request.language = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'base request examples'
  include_examples 'verification attributes examples'
  include_examples 'versioned request examples'
end
