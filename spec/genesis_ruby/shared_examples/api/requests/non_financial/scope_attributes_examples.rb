# frozen_string_literal: true

RSpec.shared_examples 'scope attributes examples' do
  describe 'when scope attributes' do
    it 'with valid value' do
      request.scope = GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::Scopes::EXTERNAL

      expect(request.build_document).to include '<scope>external</scope>'
    end

    it 'with invalid value' do
      expect { request.scope = 'invalid_value' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end
  end
end
