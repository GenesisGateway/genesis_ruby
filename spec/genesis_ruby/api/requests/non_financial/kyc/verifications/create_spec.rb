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
      request.language                        = GenesisRuby::Api::Constants::NonFinancial::Kyc::Languages.all.sample
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
      request.background_checks_date_of_birth = Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y-%m-%d')
      request.background_checks_async_update  = Faker::Boolean.boolean
      request.background_checks_filters       = GenesisRuby::Api::Constants::NonFinancial::Kyc::AmlFilters.all.sample(2)
      request.background_checks_match_score   = Faker::Number.number(digits: 2)
      request.document_first_name             = Faker::Name.first_name
      request.document_last_name              = Faker::Name.last_name
      request.document_date_of_birth          = Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y-%m-%d')
      request.document_allow_offline          = Faker::Boolean.boolean
      request.document_allow_online           = Faker::Boolean.boolean
      request.business_name                   = Faker::Company.name
      request.business_incorporation_date     = Faker::Date.backward(days: 365).strftime('%Y-%m-%d')

      request.show_consent                                     = Faker::Boolean.boolean
      request.show_privacy_policy                              = Faker::Boolean.boolean
      request.background_checks_with_alias_search              = Faker::Boolean.boolean
      request.background_checks_with_associates_search         = Faker::Boolean.boolean
      request.document_with_enhanced_data                      = Faker::Boolean.boolean
      request.document_allow_fuzzy_match                       = Faker::Boolean.boolean
      request.document_allow_decline_during_single_step        = Faker::Boolean.boolean
      request.document_with_optical_character_recognition_form = Faker::Boolean.boolean
      request.verification_instructions_allow_paper_based      = Faker::Boolean.boolean
      request.verification_instructions_allow_photocopy        = Faker::Boolean.boolean
      request.verification_instructions_allow_laminated        = Faker::Boolean.boolean
      request.verification_instructions_allow_screenshot       = Faker::Boolean.boolean
      request.verification_instructions_allow_cropped          = Faker::Boolean.boolean
      request.verification_instructions_allow_scanned          = Faker::Boolean.boolean

      expect { request.build_document }.to_not raise_error
    end

    it 'with the new boolean parameters in the payload' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
      request.show_consent                                = true
      request.show_privacy_policy                         = true
      request.background_checks_with_alias_search         = true
      request.document_with_enhanced_data                 = true
      request.verification_instructions_allow_paper_based = true

      expect(request.build_document).to include %("show_consent": true)
      expect(request.build_document).to include %("show_privacy_policy": true)
      expect(request.build_document).to include %("with_alias_search": true)
      expect(request.build_document).to include %("with_enhanced_data": true)
      expect(request.build_document).to include %("allow_paper_based": true)
    end

    it 'with the business section nested in background_checks' do # rubocop:disable RSpec/MultipleExpectations
      request.business_name               = name = Faker::Company.name
      request.business_incorporation_date = date = Faker::Date.backward(days: 365).strftime('%Y-%m-%d')

      expect(request.build_document).to include %("business": {)
      expect(request.build_document).to include %("name": "#{name}")
      expect(request.build_document).to include %("incorporation_date": "#{date}")
    end

    it 'with the business section only inside background_checks' do # rubocop:disable RSpec/MultipleExpectations
      request.business_name = Faker::Company.name

      expect(request.build_document).to include '"background_checks"'
      expect(request.build_document.scan('"business"').size).to eq 1
    end

    it 'includes verification instructions attributes' do
      expect(
        described_class.include?(GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::VerificationInstructionsAttributes)
      ).to eq true
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

    it 'with invalid show_consent' do
      expect { request.show_consent = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid show_privacy_policy' do
      expect { request.show_privacy_policy = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid background_checks_with_alias_search' do
      expect { request.background_checks_with_alias_search = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid background_checks_with_associates_search' do
      expect do
        request.background_checks_with_associates_search = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid document_with_enhanced_data' do
      expect { request.document_with_enhanced_data = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid document_allow_fuzzy_match' do
      expect { request.document_allow_fuzzy_match = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid document_allow_decline_during_single_step' do
      expect do
        request.document_allow_decline_during_single_step = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid document_with_optical_character_recognition_form' do
      expect do
        request.document_with_optical_character_recognition_form = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid verification_instructions_allow_paper_based' do
      expect do
        request.verification_instructions_allow_paper_based = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid verification_instructions_allow_photocopy' do
      expect do
        request.verification_instructions_allow_photocopy = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid verification_instructions_allow_laminated' do
      expect do
        request.verification_instructions_allow_laminated = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid verification_instructions_allow_screenshot' do
      expect do
        request.verification_instructions_allow_screenshot = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid verification_instructions_allow_cropped' do
      expect do
        request.verification_instructions_allow_cropped = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid verification_instructions_allow_scanned' do
      expect do
        request.verification_instructions_allow_scanned = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with incorporation_date set and name unset' do
      request.business_incorporation_date = Faker::Date.backward(days: 365).strftime('%Y-%m-%d')

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'base request examples'
  include_examples 'verification attributes examples'
  include_examples 'versioned request examples'
end
