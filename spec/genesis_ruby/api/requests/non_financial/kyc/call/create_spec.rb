# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/service_languages'

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Call::Create do
  let(:test_required_fields) do
    %i[
      transaction_unique_id
      customer_phone_number
      service_language
      security_code
      service_type
    ]
  end

  let(:test_required_field_values) do
    %i[
      service_type
      service_language
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

    request.transaction_unique_id = Faker::Internet.uuid
    request.customer_phone_number = '1234567890'
    request.security_code         = Faker::Number.between(from: 1000, to: 9999).to_s
    request.service_type          = described_class::SERVICE_TYPE_SMS
    request.service_language      = GenesisRuby::Api::Constants::NonFinancial::Kyc::ServiceLanguages.all.sample

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'create_authentication'
    end

    it 'with only required attributes' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with all attributes' do
      request.customer_username  = Faker::Internet.username
      request.customer_unique_id = Faker::Alphanumeric.alphanumeric(number: 8)

      expect { request.build_document }.to_not raise_error
    end

    describe 'when invalid attributes' do
      it 'with invalid phone number' do
        expect { request.customer_phone_number = 'abc123' }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'with invalid phone number format' do
        expect { request.customer_phone_number = '(123)456-7890' }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'with invalid security code format' do
        expect { request.security_code = '123' }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'with invalid security code starting with 0' do
        expect { request.security_code = '0123' }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'with invalid service type' do
        request.service_type = 66
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'with invalid service language' do
        request.service_language = 'invalid_language'
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
