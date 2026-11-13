# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/funding/person_types'

RSpec.describe GenesisRuby::Api::Constants::Transactions::Parameters::Funding::PersonTypes do

  it 'when natural constant value' do
    expect(described_class::NATURAL).to eq('natural')
  end

  it 'when legal constant value' do
    expect(described_class::LEGAL).to eq('legal')
  end

  it 'when all values' do
    expect(described_class.all).to match_array(%w(natural legal))
  end

  it 'when valid member' do
    expect(described_class.valid?('natural')).to eq(true)
  end

  it 'when invalid non-member' do
    expect(described_class.valid?('invalid')).to eq(false)
  end

end
