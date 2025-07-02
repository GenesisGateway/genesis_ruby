# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::IdentityDocument::Download do
  let(:test_required_fields) { %i[identity_document_id] }

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
    request.identity_document_id = 'DOC-12345'
    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'download_document'
    end

    it 'with identity_document_id' do
      expect(request.build_document).to include '"identity_document_id": "DOC-12345"'
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
