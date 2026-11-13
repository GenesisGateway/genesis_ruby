# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Verifications::BankAccount do
  let(:test_required_fields) { %i[bank_account_name bank_account_number bank_account_type sort_code] }

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

    request.bank_account_name   = Faker::Name.name
    request.bank_account_number = '00123456'
    request.bank_account_type   = GenesisRuby::Api::Constants::NonFinancial::Kyc::BankAccountTypes::PERSONAL
    request.sort_code           = '012345'

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'bank_account_verification'
    end

    it 'with proper endpoint' do
      request.build_document

      expect(request.api_config['url'])
        .to eq 'https://staging.kyc.emerchantpay.net:443/api/v1/bank_account_verification'
    end

    it 'with all required attributes' do # rubocop:disable RSpec/MultipleExpectations
      expect(request.build_document).to include %("bank_account_name": "#{request.bank_account_name}")
      expect(request.build_document).to include %("bank_account_number": "#{request.bank_account_number}")
      expect(request.build_document).to include %("bank_account_type": "#{request.bank_account_type}")
      expect(request.build_document).to include %("sort_code": "#{request.sort_code}")
    end

    it 'with reference_id' do
      request.reference_id = Faker::Alphanumeric.alphanumeric(number: 32)

      expect(request.build_document).to include %("reference_id": "#{request.reference_id}")
    end

    it 'without reference_id when not set' do
      expect(request.build_document).to_not include '"reference_id":'
    end
  end

  describe 'when invalid request' do
    let(:request) { described_class.new config }

    it 'with missing required attributes' do
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid bank_account_type' do
      expect { request.bank_account_type = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with too long bank_account_number' do
      expect { request.bank_account_number = '1' * 9 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with too long sort_code' do
      expect { request.sort_code = '1' * 7 }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with too long reference_id' do
      expect { request.reference_id = 'a' * 33 }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
