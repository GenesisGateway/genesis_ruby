# frozen_string_literal: true

require 'genesis_ruby/utils/money/format'

RSpec.describe GenesisRuby::Utils::Money::Format do
  describe 'can validate' do
    describe 'fails' do
      it 'raises error with floating point number when currency exponent is 0' do
        strategy = GenesisRuby::Utils::Money::Conversions::AmountToExponent.new('0.99', 'XYZ', 0)

        expect { described_class.new(strategy).convert }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'raises error with negative integer when integer amount type' do
        strategy = GenesisRuby::Utils::Money::Conversions::AmountToExponent.new(-1, 'XYZ', 2)

        expect { described_class.new(strategy).convert }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'raises error with negative decimal when float amount type' do
        strategy = GenesisRuby::Utils::Money::Conversions::AmountToExponent.new(-1.23, 'XYZ', 2)

        expect { described_class.new(strategy).convert }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'raises error with negative integer when string amount type' do
        strategy = GenesisRuby::Utils::Money::Conversions::AmountToExponent.new('-1', 'XYZ', 2)

        expect { described_class.new(strategy).convert }.to raise_error GenesisRuby::InvalidArgumentError
      end

      it 'raises error with negative decimal when string amount type' do
        strategy = GenesisRuby::Utils::Money::Conversions::AmountToExponent.new('-1.23', 'XYZ', 2)

        expect { described_class.new(strategy).convert }.to raise_error GenesisRuby::InvalidArgumentError
      end
    end

    describe 'passes' do
      it 'works with floating point number when currency exponent is 2' do
        strategy = GenesisRuby::Utils::Money::Conversions::AmountToExponent.new('1.23', 'XYZ', 2)

        expect { described_class.new(strategy).convert }.to_not raise_error
      end

      it 'works with floating point numbers when fewer decimal places than the exponent' do
        strategy = GenesisRuby::Utils::Money::Conversions::AmountToExponent.new('1.2', 'XYZ', 2)

        expect { described_class.new(strategy).convert }.to_not raise_error
      end

      it 'works with integer type amount' do
        strategy = GenesisRuby::Utils::Money::Conversions::AmountToExponent.new(1, 'XYZ', 2)

        expect { described_class.new(strategy).convert }.to_not raise_error
      end

      it 'works with float type amount' do
        strategy = GenesisRuby::Utils::Money::Conversions::AmountToExponent.new(1.2, 'XYZ', 2)

        expect { described_class.new(strategy).convert }.to_not raise_error
      end
    end
  end
end
