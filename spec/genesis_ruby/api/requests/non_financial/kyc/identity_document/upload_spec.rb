# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/identity_document_methods'

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::IdentityDocument::Upload do
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
    request.customer_username     = Faker::Internet.username
    request.customer_unique_id    = SecureRandom.uuid
    request.method                = GenesisRuby::Api::Constants::NonFinancial::Kyc::IdentityDocumentMethods.all.sample
    request.transaction_unique_id = SecureRandom.uuid
    request.add_doc(Base64.strict_encode64('test document content'), 'application/pdf')
    request
  end

  describe 'when building document' do
    let(:request) do
      request = described_class.new config
      request.method       = GenesisRuby::Api::Constants::NonFinancial::Kyc::IdentityDocumentMethods.all.sample
      request.reference_id = SecureRandom.uuid
      request.add_doc(Base64.strict_encode64('test document content'), 'application/pdf')
      request
    end

    it 'with only required attributes' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with correct request_path' do
      expect(request.__send__(:request_path)).to eq 'upload_document'
    end
  end

  describe 'when valid request' do

    it 'with all parameteres' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with transaction_unique_id' do
      request.reference_id = nil
      expect { request.build_document }.to_not raise_error
    end

    it 'with reference_id' do
      request.transaction_unique_id = nil
      request.reference_id = SecureRandom.uuid
      expect { request.build_document }.to_not raise_error
    end
  end

  describe 'when invalid request' do
    it 'with missing both transaction_unique_id and reference_id required parameters' do
      request.transaction_unique_id = nil
      request.reference_id          = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with no uploaded docs' do
      request.clear_docs
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  describe 'when method' do
    let(:request) do
      request = described_class.new config
      request.reference_id = SecureRandom.uuid
      request.add_doc(Base64.strict_encode64('test document content'), 'application/pdf')
      request
    end

    it 'with missing method' do
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with invalid method' do
      request.method = 'invalid_method'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
