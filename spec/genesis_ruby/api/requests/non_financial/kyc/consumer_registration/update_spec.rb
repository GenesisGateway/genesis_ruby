# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/profile_current_statuses'

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::ConsumerRegistration::Update do
  let(:test_required_fields) do
    %i[reference_id profile_current_status]
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

    request.reference_id           = Faker::Internet.uuid
    request.profile_current_status = GenesisRuby::Api::Constants::NonFinancial::Kyc::ProfileCurrentStatuses.all.sample
    request.status_reason          = Faker::Lorem.sentence(word_count: 1)

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'update_consumer'
    end

    it 'with all required attributes' do
      expect { request.build_document }.to_not raise_error
    end

    describe 'when invalid attributes' do
      it 'with invalid profile_current_status' do
        request.profile_current_status = 11
        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
