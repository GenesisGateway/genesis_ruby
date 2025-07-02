# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/cards/tokenization_params_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::TokenizationParamsAttributes do
  let(:tokenization) { GenesisSpec::Stubs::Api::Requests::Financial::Cards::TokenizationParamsAttributesStub.new }

  describe 'when tokenization_tavv accessors' do
    it 'with setter' do
      expect { tokenization.tokenization_tavv = Faker::Internet.uuid }.to_not raise_error
    end

    it 'with getter' do
      tokenization.tokenization_tavv = value = Faker::Internet.uuid

      expect(tokenization.tokenization_tavv).to eq value
    end
  end

  describe 'when tokenization_eci accessors' do
    it 'with setter' do
      expect { tokenization.tokenization_eci = Faker::Number.leading_zero_number(digits: 2) }.to_not raise_error
    end

    it 'with getter' do
      tokenization.tokenization_eci = value = Faker::Number.leading_zero_number(digits: 2)

      expect(tokenization.tokenization_eci).to eq value
    end
  end

end
