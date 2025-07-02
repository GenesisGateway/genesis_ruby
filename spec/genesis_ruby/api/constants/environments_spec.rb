# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Constants::Environments do
  it 'has valid production environment' do
    expect(described_class::PRODUCTION).to eq('production')
  end

  it 'has valid staging environment' do
    expect(described_class::STAGING).to eq('sandbox')
  end
end
