# frozen_string_literal: true

require 'genesis_ruby/utils/money_format'

RSpec.describe GenesisRuby::Utils::MoneyFormat do
  describe 'can convert corresponding to the API Docs' do
    describe 'amount to exponent' do
      it 'with USD when currency exponent 2' do
        expect(described_class.amount_to_exponent(100.33, 'USD')).to eq('10033')
      end

      it 'with EUR when currency exponent 2' do
        expect(described_class.amount_to_exponent(3, 'EUR')).to eq('300')
      end

      it 'with JPN when currency exponent 0' do
        expect(described_class.amount_to_exponent(150, 'JPN')).to eq('150')
      end

      it 'with KWD when currency exponent 3' do
        expect(described_class.amount_to_exponent(100.333, 'KWD')).to eq('100333')
      end

      it 'raises error with invalid currency exponent' do
        expect do
          described_class.amount_to_exponent(1.234, 'EUR')
        end.to raise_error GenesisRuby::InvalidArgumentError
      end
    end

    describe 'exponent to amount' do
      it 'with USD when currency exponent 2' do
        expect(described_class.exponent_to_amount(10_033, 'USD')).to eq('100.33')
      end

      it 'with EUR when currency exponent 2' do
        expect(described_class.exponent_to_amount(300, 'EUR')).to eq('3.00')
      end

      it 'with JPN when currency exponent 0' do
        expect(described_class.exponent_to_amount(150, 'JPN')).to eq('150')
      end

      it 'with KWD when currency exponent 3' do
        expect(described_class.exponent_to_amount(100_333, 'KWD')).to eq('100.333')
      end

      it 'raises error with invalid currency exponent' do
        expect do
          described_class.exponent_to_amount(1.23, 'JPN')
        end.to raise_error GenesisRuby::InvalidArgumentError
      end
    end
  end
end
