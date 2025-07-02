# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/cards/tokenization_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Cards::TokenizationAttributes do
  let(:tokenization) { GenesisSpec::Stubs::Api::Requests::Financial::Cards::TokenizationAttributesStub.new }

  describe 'when token accessors' do
    it 'with setter' do
      expect { tokenization.token = Faker::Number.positive }.to_not raise_error
    end

    it 'with getter' do
      tokenization.token = token = Faker::Number.positive

      expect(tokenization.token).to eq token
    end
  end

  describe 'when consumer_id accessors' do
    it 'with setter' do
      expect { tokenization.consumer_id = Faker::Number.positive }.to_not raise_error
    end

    it 'with getter' do
      tokenization.consumer_id = identifier = Faker::Number.positive

      expect(tokenization.consumer_id).to eq identifier
    end
  end

  describe 'when remember_card accessors' do
    describe 'with valid values' do
      it 'with setter' do
        expect { tokenization.remember_card = true }.to_not raise_error
      end

      it 'with getter' do
        tokenization.remember_card = remember_card = true

        expect(tokenization.remember_card).to eq remember_card
      end
    end

    describe 'with invalid values' do
      it 'with setter' do
        expect { tokenization.remember_card = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
      end
    end
  end
end
