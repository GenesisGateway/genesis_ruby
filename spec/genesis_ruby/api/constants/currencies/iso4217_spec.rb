# frozen_string_literal: true

require 'genesis_ruby/api/constants/currencies/iso4217'

RSpec.describe GenesisRuby::Api::Constants::Currencies::Iso4217 do
  let(:currency_exponent) do
    {
      zero:  'JPY',
      NA:    'XAU',
      two:   'EUR',
      three: 'BHD'
    }
  end

  describe 'can fetch exponent' do
    it 'works with ISO-4217 currency code when uppercase' do
      expect(described_class.fetch_exponent(currency_exponent[:two].upcase)).to be(2)
    end

    it 'works with invalid ISO-4217 currency code' do
      expect(described_class.fetch_exponent('invalid')).to be(0)
    end

    it 'works with ISO-4217 currency code when downcase' do
      expect(described_class.fetch_exponent(currency_exponent[:two].downcase)).to be(2)
    end

    it 'fetch when exponent 3' do
      expect(described_class.fetch_exponent(currency_exponent[:three])).to be(3)
    end

    it 'fetch when exponent N.A.' do
      expect(described_class.fetch_exponent(currency_exponent[:NA])).to be(0)
    end
  end

  describe 'has all currencies' do
    it 'returns array with all currencies' do
      expect(described_class.all).to be_kind_of(Array)
    end

    it 'returns strings with all currencies' do
      expect(described_class.all).to include(currency_exponent[:two].downcase)
    end
  end

  describe 'has valid currency' do
    it 'works with valid currency when upcase' do
      expect(described_class.valid?(currency_exponent[:two].upcase)).to eq(true)
    end

    it 'works with valid currency when downcase' do
      expect(described_class.valid?(currency_exponent[:two].downcase)).to eq(true)
    end

    it 'works with invalid currency' do
      expect(described_class.valid?('invalid')).to eq(false)
    end
  end
end
