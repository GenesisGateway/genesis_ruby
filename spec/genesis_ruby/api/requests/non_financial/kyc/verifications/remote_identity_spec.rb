RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Verifications::RemoteIdentity do
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

    request.email                    = Faker::Internet.email
    request.reference_id             = Faker::Number.number(digits: 10)
    request.country                  = GenesisRuby::Utils::Country::COUNTRIES.keys.sample
    request.backside_proof_required  = Faker::Boolean.boolean
    request.expiry_date              = Faker::Date.forward(days: 100).strftime('%Y-%m-%d')
    request.proof                    = 'base64_encoded_document'
    request.first_name               = Faker::Name.first_name
    request.middle_name              = Faker::Name.middle_name
    request.last_name                = Faker::Name.last_name
    request.date_of_birth            = Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y-%m-%d')
    request.full_address             = Faker::Address.full_address
    request.document_supported_types =
      GenesisRuby::Api::Constants::NonFinancial::Kyc::DocumentSupportedTypes.all.sample(2)

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'verifications'
    end

    it 'with all required attributes' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with diffierent expiry_date format' do
      request.expiry_date = '31-12-2025'
      expect(request.build_document).to include '"expiry_date": "2025-12-31"'
    end
  end

  describe 'when only required attributes' do
    let(:request) { described_class.new(config) }

    it 'with only email' do
      request.email = Faker::Internet.email
      expect { request.build_document }.to_not raise_error
    end

    it 'with only reference_id' do
      request.reference_id = Faker::Number.number(digits: 10)
      expect { request.build_document }.to_not raise_error
    end

    it 'with both email and reference_id' do
      request.email        = Faker::Internet.email
      request.reference_id = Faker::Number.number(digits: 10)
      expect { request.build_document }.to_not raise_error
    end
  end

  describe 'when invalid request' do
    let(:request) { described_class.new(config) }

    it 'with none of the requred attributes' do
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid email format' do
      expect { request.email = 'invalid_email' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid country code' do
      request.country = 'XX'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid backside_proof_required' do
      request.backside_proof_required = 'maybe'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid document_supported_types' do
      expect { request.document_supported_types = ['invalid_type'] }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid backside_proof_required as string' do
      request.backside_proof_required = 'true'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with too long first_name' do
      expect do
        request.first_name = Faker::Alphanumeric.alphanumeric(number: 40)
      end.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'with too long middle_name' do
      expect do
        request.middle_name = Faker::Alphanumeric.alphanumeric(number: 40)
      end.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'with too long last_name' do
      expect do
        request.last_name = Faker::Alphanumeric.alphanumeric(number: 40)
      end.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
