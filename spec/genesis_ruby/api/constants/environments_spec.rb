RSpec.describe GenesisRuby::Api::Constants::Environments do
  it 'has valid production environment' do
    expect(GenesisRuby::Api::Constants::Environments::PRODUCTION).to eq('production')
  end

  it 'has valid staging environment' do
    expect(GenesisRuby::Api::Constants::Environments::STAGING).to eq('sandbox')
  end
end
