# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Verifications::AddressByDocumentProof do
  let(:test_required_fields) { %i[reference_id full_address proof] }

  let(:config) do
    config = GenesisRuby::Configuration.new
    config.username = 'example_username'
    config.password = 'example_password'
    config.token = 'example_token'
    config.endpoint = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end

  let(:request) do
    request = described_class.new(config)

    request.reference_id = Faker::Number.number(digits: 10)
    request.document_supported_types =
      GenesisRuby::Api::Constants::NonFinancial::Kyc::AddressDocumentSupportedTypes.all.sample(2)
    request.full_address = Faker::Address.full_address
    request.proof = 'base64_encoded_document'

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'verifications/address/by_proof'
    end

    it 'with all required attributes' do # rubocop:disable RSpec/MultipleExpectations
      expect(request.build_document).to include %("reference_id": #{request.reference_id})
      expect(request.build_document).to include %("document_supported_types": [)
      expect(request.build_document).to include %("full_address": "#{request.full_address}")
      expect(request.build_document).to include %("proof": "#{request.proof}")
    end

    it 'with all attributes' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
      request.backside_proof_required = Faker::Boolean.boolean
      request.with_enhanced_address_verification = Faker::Boolean.boolean
      request.with_async_workflow = Faker::Boolean.boolean
      request.first_name = Faker::Name.first_name
      request.middle_name = Faker::Name.middle_name
      request.last_name = Faker::Name.last_name

      expect(request.build_document).to include %("backside_proof_required": #{request.backside_proof_required})
      expect(request.build_document).to include(
        %("with_enhanced_address_verification": #{request.with_enhanced_address_verification})
      )
      expect(request.build_document).to include %("with_async_workflow": #{request.with_async_workflow})
      expect(request.build_document).to include %("first_name": "#{request.first_name}")
      expect(request.build_document).to include %("middle_name": "#{request.middle_name}")
      expect(request.build_document).to include %("last_name": "#{request.last_name}")
    end

    it 'without unsupported verification attributes in payload' do # rubocop:disable RSpec/MultipleExpectations
      expect(request.build_document).to_not include '"country":'
      expect(request.build_document).to_not include '"expiry_date":'
    end
  end

  describe 'when invalid request' do
    let(:request) { described_class.new(config) }

    it 'with missing required attributes' do
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid with_enhanced_address_verification' do
      expect do
        request.with_enhanced_address_verification = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid backside_proof_required' do
      expect do
        request.backside_proof_required = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid document_supported_types' do
      expect do
        request.document_supported_types = ['invalid_type']
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid with_async_workflow' do
      expect do
        request.with_async_workflow = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
