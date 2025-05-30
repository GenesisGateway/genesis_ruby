require 'genesis_ruby/api/constants/non_financial/kyc/profile_current_statuses'

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::ConsumerRegistration::Create do
  let(:test_required_fields) do
    %i[
      first_name last_name customer_email address1 city province zip_code country
      customer_unique_id customer_registration_date customer_registration_ip_address
    ]
  end

  let(:config) do
    config = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end

  let(:request) do
    request = described_class.new config

    request.first_name                       = Faker::Name.first_name
    request.last_name                        = Faker::Name.last_name
    request.customer_email                   = Faker::Internet.email
    request.address1                         = Faker::Address.street_address
    request.city                             = Faker::Address.city
    request.zip_code                         = Faker::Address.zip_code
    request.country                          = Faker::Address.country_code
    request.province                         = Faker::Address.state

    request.session_id                       = Faker::Internet.uuid
    request.customer_unique_id               = Faker::Alphanumeric.alphanumeric(number: 8)
    request.customer_registration_date       = Faker::Date.backward(days: 1000).strftime('%Y-%m-%d')
    request.customer_registration_ip_address = Faker::Internet.public_ip_v4_address

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'create_consumer'
    end

    it 'with only required attributes' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with all required attributes' do # rubocop:disable RSpec/ExampleLength
      request.middle_name                     = Faker::Name.middle_name
      request.address2                        = Faker::Address.secondary_address
      request.phone1                          = Faker::PhoneNumber.phone_number
      request.phone2                          = Faker::PhoneNumber.phone_number
      request.birth_date                      = Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y-%m-%d')
      request.document_number                 = Faker::Alphanumeric.alphanumeric(number: 10)
      request.document_type                   = GenesisRuby::Api::Constants::NonFinancial::Kyc::DocumentTypes.all.sample
      request.gender                          = GenesisRuby::Api::Constants::NonFinancial::Kyc::Genders.all.sample

      request.customer_username               = Faker::Internet.username
      request.customer_registration_device_id = Faker::Alphanumeric.alphanumeric(number: 10)
      request.third_party_device_id           = Faker::Alphanumeric.alphanumeric(number: 10)
      request.device_fingerprint              = Faker::Internet.uuid
      request.device_fingerprint_type         = Faker::Number.between(from: 1, to: 3)
      request.profile_action_type             = Faker::Number.between(from: 1, to: 2)
      request.profile_current_status          = GenesisRuby::Api::Constants::NonFinancial::Kyc::ProfileCurrentStatuses.all.sample # rubocop:disable Layout/LineLength
      request.bonus_code                      = Faker::Alphanumeric.alphanumeric(number: 4)
      request.bonus_submission_date           = Faker::Date.backward(days: 1000).strftime('%Y-%m-%d')
      request.bonus_amount                    = Faker::Number.between(from: 50, to: 150)
      request.merchant_website                = Faker::Internet.domain_name
      request.industry_type                   = Faker::Number.between(from: 0, to: 9)
      request.how_did_you_hear                = Faker::Lorem.word
      request.affiliate_id                    = Faker::Number.number(digits: 4)
      request.rule_context                    = Faker::Number.number

      expect { request.build_document }.to_not raise_error
    end

    describe 'when valid attributes' do
      it 'with setting string device_fingerprint_type' do
        request.device_fingerprint_type = '1'
        expect { request.build_document }.to_not raise_error
      end

      it 'with setting string profile_action_type' do
        request.profile_action_type = '1'
        expect { request.build_document }.to_not raise_error
      end

      it 'with setting string profile_current_status' do
        request.profile_current_status = '1'
        expect { request.build_document }.to_not raise_error
      end

      it 'with setting string industry_type' do
        request.industry_type = '1'
        expect { request.build_document }.to_not raise_error
      end
    end

    describe 'when invalid attributes' do
      it 'with invalid device_fingerprint_type' do
        request.device_fingerprint_type = 11
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'with invalid profile_action_type' do
        request.profile_action_type = 11
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'with invalid profile_current_status' do
        request.profile_current_status = 11
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'with invalid industry_type' do
        request.industry_type = 11
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end
    end

    describe 'when invalid customer_information_attributes data' do
      it 'with setting invalid document type' do
        request.document_type = 'invalid_doc_type'
        expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
      end

      it 'with setting invalid gender' do
        request.gender = 'invalid_gender'
        expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
      end
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
