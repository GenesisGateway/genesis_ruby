# frozen_string_literal: true

RSpec.shared_examples 'processing type attributes examples' do
  describe 'when processing_type attributes' do
    it 'with valid value' do
      request.processing_type = value =
        GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::ProcessingType.all.sample

      expect(request.build_document).to include "<processing_type>#{value}</processing_type>"
    end

    it 'with invalid value' do
      request.processing_type = 'invalid_value'

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end
end
