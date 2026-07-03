# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Owners::CreateOwnerDocument do
  let(:test_required_fields) { %i[owner_unique_id document_type file] }
  let(:test_required_field_values) { %i[document_type] }
  let(:config) do
    config = GenesisRuby::Configuration.new
    config.username = 'example_username'
    config.password = 'example_password'
    config.token = 'example_token'
    config.endpoint = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:sample_data) do
    {
      owner_unique_id: Faker::Internet.uuid,
      document_type:   GenesisRuby::Api::Constants::NonFinancial::Payee::DocumentTypes.all.sample,
      file:            Faker::Alphanumeric.alphanumeric(number: 32)
    }
  end
  let(:request) do
    request = described_class.new config

    request.owner_unique_id = sample_data[:owner_unique_id]
    request.document_type = sample_data[:document_type]
    request.file = sample_data[:file]

    request
  end

  it 'when building document with proper request structure' do # rubocop:disable RSpec/MultipleExpectations
    parsed = JSON.parse(request.build_document)

    expect(parsed['document']['document_type']).to eq sample_data[:document_type]
    expect(parsed['document']['file']).to eq sample_data[:file]
  end

  it 'when configured with proper endpoint url' do
    request.build_document

    expect(request.api_config['url']).to eq(
      "https://staging.api.emerchantpay.net:443/payee/owners/#{sample_data[:owner_unique_id]}/documents"
    )
  end

  it 'when using POST HTTP request type' do
    expect(request.api_config['type']).to eq 'POST'
  end

  it 'when configured without token in configuration' do
    request.build_document

    expect(request.api_config['token']).to be_nil
  end

  context 'when validating fields' do
    it 'with missing owner_unique_id should raise error' do
      request.owner_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with missing document_type should raise error' do
      request.document_type = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with missing file should raise error' do
      request.file = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with invalid document_type should raise error' do
      request.document_type = 'invalid_type'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with valid parameters should not raise error' do
      expect { request.build_document }.to_not raise_error
    end
  end

  context 'when processing request parameters' do
    it 'replaces placeholder in request path with actual owner_unique_id' do
      request.owner_unique_id = 'custom_owner_789'
      request.build_document

      expect(request.api_config['url']).to include('payee/owners/custom_owner_789/documents')
    end
  end

  include_examples 'base request examples'
end
