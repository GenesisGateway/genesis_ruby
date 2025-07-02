# frozen_string_literal: true

require 'genesis_ruby/utils/money/conversions/amount_to_exponent'

RSpec.describe GenesisRuby::Utils::Money::Conversions::AmountToExponent do
  let(:currencies) do
    {
      zero:  {
        currency: 'JPY',
        exponent: 0
      },
      NA:    {
        currency: 'XAU',
        exponent: 0
      },
      two:   {
        currency: 'EUR',
        exponent: 2
      },
      three: {
        currency: 'BHD',
        exponent: 3
      },
      four:  {
        currency: 'CLF',
        exponent: 4
      }
    }
  end

  describe 'with currency exponent 0' do
    it 'when float point amount' do
      expect(
        described_class.new('1.01', currencies[:zero][:currency], currencies[:zero][:exponent]).convert
      ).to eq('1')
    end

    it 'when integer amount' do
      expect(
        described_class.new('1', currencies[:zero][:currency], currencies[:zero][:exponent]).convert
      ).to eq('1')
    end
  end

  describe 'with currency exponent N.A.' do
    it 'when float point amount' do
      expect(
        described_class.new('1.01', currencies[:NA][:currency], currencies[:NA][:exponent]).convert
      ).to eq('1')
    end

    it 'when integer amount' do
      expect(
        described_class.new('1', currencies[:NA][:currency], currencies[:NA][:exponent]).convert
      ).to eq('1')
    end
  end

  describe 'with currency exponent 2' do
    it 'when floating point amount' do
      expect(
        described_class.new('1.01', currencies[:two][:currency], currencies[:two][:exponent]).convert
      ).to eq('101')
    end

    it 'when integer amount' do
      expect(
        described_class.new('1.00', currencies[:two][:currency], currencies[:two][:exponent]).convert
      ).to eq('100')
    end
  end

  describe 'with currency exponent 3' do
    it 'when floating point amount' do
      expect(
        described_class.new('1.010', currencies[:three][:currency], currencies[:three][:exponent]).convert
      ).to eq('1010')
    end

    it 'when integer amount' do
      expect(
        described_class.new('1', currencies[:three][:currency], currencies[:three][:exponent]).convert
      ).to eq('1000')
    end
  end

  describe 'with currency exponent 4' do
    it 'when floating point amount' do
      expect(
        described_class.new('1.1010', currencies[:four][:currency], currencies[:four][:exponent]).convert
      ).to eq('11010')
    end

    it 'when integer amount' do
      expect(
        described_class.new('1', currencies[:four][:currency], currencies[:four][:exponent]).convert
      ).to eq('10000')
    end
  end

  describe 'truncates amount' do
    it 'when exponent currency 3' do
      expect(
        described_class.new('1.01', currencies[:three][:currency], currencies[:three][:exponent]).convert
      ).to eq('1010')
    end

    it 'when exponent currency 2' do
      expect(
        described_class.new('1.1', currencies[:two][:currency], currencies[:two][:exponent]).convert
      ).to eq('110')
    end

    it 'when exponent currency 4' do
      expect(
        described_class.new('1.011', currencies[:four][:currency], currencies[:four][:exponent]).convert
      ).to eq('10110')
    end

    it 'with floating point number when exponent currency 0' do
      expect(
        described_class.new('1.99', currencies[:zero][:currency], currencies[:zero][:exponent]).convert
      ).to eq('1')
    end

    it 'with floating point numbers when exponent currency 2' do
      expect(
        described_class.new('1.999', currencies[:two][:currency], currencies[:two][:exponent]).convert
      ).to eq('199')
    end

    it 'with floating point numbers when exponent currency 3' do
      expect(
        described_class.new('1.9999', currencies[:three][:currency], currencies[:three][:exponent]).convert
      ).to eq('1999')
    end

    it 'with floating point numbers when exponent currency 4' do
      expect(
        described_class.new('1.99999', currencies[:four][:currency], currencies[:four][:exponent]).convert
      ).to eq('19999')
    end
  end

  it 'has string return value' do
    expect(described_class.new(
      Faker::Number.decimal(l_digits: 2, r_digits: 2),
      currencies[currencies.keys.sample][:currency],
      currencies[currencies.keys.sample][:exponent]
    ).convert).to be_kind_of String
  end
end
