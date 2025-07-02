# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/transaction_statuses'

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Transaction::Update do
  let(:test_required_fields) do
    %i[transaction_unique_id]
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
    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'update_transaction'
    end

    it 'with only required attributes' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with all attributes' do # rubocop:disable RSpec/ExampleLength
      request.session_id            = Faker::Internet.uuid
      request.reference_id          = Faker::Internet.uuid
      request.transaction_status    = GenesisRuby::Api::Constants::NonFinancial::Kyc::TransactionStatuses.all.sample
      request.reason                = Faker::Lorem.sentence
      request.cvv_check_result      = Faker::Lorem.word
      request.avs_check_result      = Faker::Lorem.word
      request.processor_identifier  = Faker::Lorem.word

      expect { request.build_document }.to_not raise_error
    end
  end

  describe 'transaction_status' do
    it 'with transaction_status as string' do
      request.transaction_status = '1'
      expect(request.transaction_status).to eq 1
    end
  end

  describe 'when invalid attributes' do
    it 'with invalid transaction_status' do
      request.transaction_status = 335
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with missing required transaction_unique_id' do
      request.transaction_unique_id = nil
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'request_structure' do
    it 'returns correct structure' do # rubocop:disable RSpec/ExampleLength
      request.session_id            = 'session_123'
      request.reference_id          = 'ref_456'
      request.transaction_status    = 1
      request.reason                = 'Test reason'
      request.cvv_check_result      = 'match'
      request.avs_check_result      = 'match'
      request.processor_identifier  = 'processor_123'

      expected_structure = {
        session_id:            'session_123',
        transaction_unique_id: request.transaction_unique_id,
        reference_id:          'ref_456',
        transaction_status:    1,
        reason:                'Test reason',
        cvv_check_result:      'match',
        avs_check_result:      'match',
        processor_identifier:  'processor_123'
      }

      expect(request.request_structure).to eq expected_structure
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
