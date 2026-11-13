# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/scope_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::ScopeAttributes do
  let(:scope) { GenesisRuby::Api::Constants::Transactions::Parameters::NonFinancial::Scopes::CARD_PRESENT }
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::NonFinancial::ScopeAttributesStub.new }

  describe 'when scope accessors' do
    it 'with setter' do
      expect { attributes.scope = scope }.to_not raise_error
    end

    it 'with getter' do
      attributes.scope = scope

      expect(attributes.scope).to eq scope
    end
  end

  describe 'when scope' do
    it 'with invalid value' do
      expect { attributes.scope = 'invalid' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'with upper case value' do
      expect { attributes.scope = 'CARD_PRESENT' }.to raise_error(GenesisRuby::InvalidArgumentError)
    end

    it 'with nil value' do
      expect { attributes.scope = nil }.to_not raise_error
    end

    it 'with empty value' do
      expect { attributes.scope = '' }.to_not raise_error
    end

    it 'with nil value after a valid value' do
      attributes.scope = scope
      attributes.scope = nil

      expect(attributes.scope).to be_nil
    end
  end
end
