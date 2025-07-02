# frozen_string_literal: true

RSpec.shared_examples 'externally processed attributes examples' do
  describe 'when externally_processed attributes' do
    it 'with valid value' do
      request.externally_processed = value =
        GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::ExternallyProcessed.all.sample

      expect(request.build_document).to include "<externally_processed>#{value}</externally_processed>"
    end

    it 'with invalid value' do
      request.externally_processed = 'invalid_value'

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end
end
