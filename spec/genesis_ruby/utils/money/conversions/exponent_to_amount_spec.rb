require 'genesis_ruby/utils/money/conversions/exponent_to_amount'

RSpec.describe GenesisRuby::Utils::Money::Conversions::ExponentToAmount do
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
    it 'when floating point amount' do
      expect(
        described_class.new('199.99', currencies[:zero][:currency], currencies[:zero][:exponent]).convert
      ).to eq('199')
    end

    it 'when integer amount' do
      expect(
        described_class.new('199', currencies[:zero][:currency], currencies[:zero][:exponent]).convert
      ).to eq('199')
    end
  end

  describe 'with currency exponent N.A.' do
    it 'when floating point amount' do
      expect(
        described_class.new('199.99', currencies[:NA][:currency], currencies[:NA][:exponent]).convert
      ).to eq('199')
    end

    it 'when integer amount' do
      expect(
        described_class.new('199', currencies[:NA][:currency], currencies[:NA][:exponent]).convert
      ).to eq('199')
    end
  end

  describe 'with currency exponent 2' do
    it 'when floating point amount' do
      expect(
        described_class.new('199.99', currencies[:two][:currency], currencies[:two][:exponent]).convert
      ).to eq('1.99')
    end

    it 'when integer amount' do
      expect(
        described_class.new('199', currencies[:two][:currency], currencies[:two][:exponent]).convert
      ).to eq('1.99')
    end
  end

  describe 'with currency exponent 3' do
    it 'when floating point amount' do
      expect(
        described_class.new('19999.99', currencies[:three][:currency], currencies[:three][:exponent]).convert
      ).to eq('19.999')
    end

    it 'when integer amount' do
      expect(
        described_class.new('19999', currencies[:three][:currency], currencies[:three][:exponent]).convert
      ).to eq('19.999')
    end
  end

  describe 'with currency exponent 4' do
    it 'when floating point amount' do
      expect(
        described_class.new('19999.99', currencies[:four][:currency], currencies[:four][:exponent]).convert
      ).to eq('1.9999')
    end

    it 'when integer amount' do
      expect(
        described_class.new('199999', currencies[:four][:currency], currencies[:four][:exponent]).convert
      ).to eq('19.9999')
    end
  end

  describe 'truncates amount' do
    it 'when exponent currency 2' do
      expect(
        described_class.new('1', currencies[:two][:currency], currencies[:two][:exponent]).convert
      ).to eq('0.01')
    end

    it 'when exponent currency 3' do
      expect(
        described_class.new('1', currencies[:three][:currency], currencies[:three][:exponent]).convert
      ).to eq('0.001')
    end

    it 'when exponent currency 4' do
      expect(
        described_class.new('1', currencies[:four][:currency], currencies[:four][:exponent]).convert
      ).to eq('0.0001')
    end

    it 'with floating point numbers when exponent 2' do
      expect(
        described_class.new(10.999, currencies[:two][:currency], currencies[:two][:exponent]).convert
      ).to eq('0.10')
    end

    it 'with floating point numbers when exponent 3' do
      expect(
        described_class.new(100.999, currencies[:three][:currency], currencies[:three][:exponent]).convert
      ).to eq('0.100')
    end

    it 'with floating point numbers when exponent 4' do
      expect(
        described_class.new(100.999, currencies[:four][:currency], currencies[:four][:exponent]).convert
      ).to eq('0.0100')
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
