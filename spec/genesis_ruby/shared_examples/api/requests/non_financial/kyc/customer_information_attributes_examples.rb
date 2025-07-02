# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/customer_information_attributes_stub'

RSpec.shared_examples 'customer information attributes examples' do
  let(:customer_information_attributes) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::CustomerInformationAttributesStub.new
  end

  describe 'when invalid data' do
    it 'with invalid gender' do
      request.gender = 'invalid'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with invalid document type' do
      request.document_type = 'invalid_doc_type'
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

end
