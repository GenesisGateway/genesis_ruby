# frozen_string_literal: true

require 'genesis_ruby/utils/money/base/strategy'

RSpec.describe GenesisRuby::Utils::Money::Base::Strategy do
  describe 'can parse amount' do
    it 'works with integer type amount' do
      expect(
        described_class.new(Faker::Number.number, 'EUR', 2).amount
      ).to be_kind_of BigDecimal
    end

    it 'works with floating point amount' do
      expect(
        described_class.new(Faker::Number.decimal(l_digits: 2, r_digits: 10), 'EUR', 2).amount
      ).to be_kind_of BigDecimal
    end

    it 'fails with invalid amount' do
      expect do
        described_class.new('invalid', 'EUR', 2)
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'has convert method' do
      expect do
        described_class.new(Faker::Number.number, 'EUR', 2).convert
      end.to raise_error NotImplementedError
    end
  end
end
