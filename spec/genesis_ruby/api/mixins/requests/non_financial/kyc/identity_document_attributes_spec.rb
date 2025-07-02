# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/identity_document_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::IdentityDocumentAttributes do
  let(:identity_document_attributes) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::IdentityDocumentAttributesStub.new
  end

  let(:base64_content) { Base64.strict_encode64('test document content') }
  let(:mime_type) { 'application/pdf' }

  describe 'when docs' do
    it 'initializes an empty array' do
      expect(identity_document_attributes.docs).to eq([])
    end
  end

  describe 'when get_doc' do
    it 'returns document at specified index' do
      identity_document_attributes.add_doc(base64_content, mime_type)
      expected_doc = { base64_content: base64_content, mime_type: mime_type }
      expect(identity_document_attributes.get_doc(0)).to eq(expected_doc)
    end
  end

  describe 'when add_doc' do
    context 'when adding a valid document' do
      before do
        identity_document_attributes.add_doc(base64_content, mime_type)
      end

      it 'increases the documents count' do
        expect(identity_document_attributes.docs.size).to eq(1)
      end
    end

    it 'raises error when max documents exceeded' do # rubocop:disable RSpec/ExampleLength
      (GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::IdentityDocumentAttributes::MAX_DOCUMENTS + 1).times do
        identity_document_attributes.add_doc(base64_content, mime_type)
      rescue GenesisRuby::InvalidArgumentError => e
        expect(e.message).to eq("Maximum of #{GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::IdentityDocumentAttributes::MAX_DOCUMENTS} documents allowed") # rubocop:disable Layout/LineLength
        break
      end
    end
  end

  describe 'when clear_docs' do
    before do
      identity_document_attributes.add_doc(base64_content, mime_type)
      identity_document_attributes.clear_docs
    end

    it 'clears all documents' do
      expect(identity_document_attributes.docs).to be_empty
    end
  end
end
