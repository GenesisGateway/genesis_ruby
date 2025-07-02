# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/verification_statuses'

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Call::Update do
  let(:test_required_fields) do
    %i[
      reference_id
      security_code_input
      verification_status
    ]
  end

  let(:test_required_field_values) do
    %i[verification_status]
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

    request.reference_id        = Faker::Internet.uuid
    request.security_code_input = Faker::Number.between(from: 1000, to: 9999).to_s
    request.verification_status = GenesisRuby::Api::Constants::NonFinancial::Kyc::VerificationStatuses.all.sample

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'update_authentication'
    end

    it 'with only required attributes' do
      expect { request.build_document }.to_not raise_error
    end

    describe 'when invalid attributes' do
      it 'with invalid verification status' do
        request.verification_status = 'invalid_status'
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'with missing reference_id' do
        request.reference_id = nil
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'with missing security code input' do
        request.security_code_input = nil
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'with missing verification_status' do
        request.verification_status = nil
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
