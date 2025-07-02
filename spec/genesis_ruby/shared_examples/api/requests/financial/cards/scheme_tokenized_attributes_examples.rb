# frozen_string_literal: true

RSpec.shared_examples 'scheme tokenized attributes examples' do
  describe 'when scheme_tokenized' do
    it 'without value' do
      expect(request.build_document).to_not include 'scheme_tokenized'
    end

    it 'with valid value' do
      request.scheme_tokenized = true

      expect(request.build_document).to include '<scheme_tokenized>true</scheme_tokenized>'
    end

    it 'with invalid value' do
      expect { request.scheme_tokenized = 'false' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
