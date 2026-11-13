# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/foreign_retailer_indicators'
require 'spec/genesis_ruby/shared_examples/api/constants/common_examples'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::ForeignRetailerIndicators do

  include_examples 'common constants examples', 'F'

  it 'defines the foreign retailer value' do
    expect(described_class::FOREIGN_RETAILER).to eq 'F'
  end

  it 'returns exactly one value' do
    expect(described_class.all).to eq ['F']
  end

  [nil, '', 'f', 'FF'].each do |value|
    it "rejects #{value.inspect} in strict mode" do
      expect(described_class.valid?(value, strict: true)).to eq false
    end
  end

  %w(F f).each do |value|
    it "rejects #{value.inspect} in non-strict mode" do
      expect(described_class.valid?(value)).to eq false
    end
  end

end
