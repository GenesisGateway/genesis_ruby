# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/gift_cards_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::GiftCardsAttributes do
  let(:gift_cards) { GenesisSpec::Stubs::Api::Requests::Financial::GiftCardsAttributesStub.new }

  describe 'when card_number' do
    it 'with setter' do
      expect { gift_cards.card_number = Faker::Number.number(digits: 21).to_s }.to_not raise_error
    end

    it 'with getter' do
      gift_cards.card_number = number = Faker::Number.number(digits: 21).to_s

      expect(gift_cards.card_number).to eq number
    end

    it 'with invalid short value' do
      expect { gift_cards.card_number = Faker::Number.number(digits: 18).to_s }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid long value' do
      expect { gift_cards.card_number = Faker::Number.number(digits: 22).to_s }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when cvv' do
    it 'with setter' do
      expect { gift_cards.cvv = Faker::Number.number(digits: 5).to_s }.to_not raise_error
    end

    it 'with getter' do
      gift_cards.cvv = cvv = Faker::Number.number(digits: 5).to_s

      expect(gift_cards.cvv).to eq cvv
    end

    it 'with invalid short value' do
      expect { gift_cards.cvv = Faker::Number.number(digits: 3).to_s }
        .to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid long value' do
      expect { gift_cards.cvv = Faker::Number.number(digits: 10).to_s }
        .to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
