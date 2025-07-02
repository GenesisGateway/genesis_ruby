# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Constants::States do
  it 'when all method' do
    expect(described_class.all).to be_kind_of Array
  end

  it 'when valid method' do
    expect(described_class.valid?('new')).to eq(true)
  end
end
