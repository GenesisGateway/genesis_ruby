# frozen_string_literal: true

require 'genesis_ruby/utils/country'

RSpec.describe GenesisRuby::Utils::Country do

  subject(:country_util) { described_class.new }

  describe 'when country_name' do
    it 'with valid ISO code' do
      expect(country_util.country_name('US')).to eq('United States')
    end

    it 'with given an invalid ISO code' do
      expect(country_util.country_name('XX')).to eq(false)
    end
  end

  describe 'when country_iso' do
    it 'with valid country name' do
      expect(country_util.country_iso('United States')).to eq('US')
    end

    it 'when invalid country name' do
      expect(country_util.country_iso('Unknownland')).to be_nil
    end
  end

  describe 'when list' do
    it 'returns an Array' do
      expect(country_util.list).to be_an(Array)
    end

    it 'includes US' do
      expect(country_util.list).to include('US')
    end

    it 'matches the number of country codes defined' do
      expect(country_util.list.length).to eq(GenesisRuby::Utils::Country::COUNTRIES.keys.length)
    end
  end
end
