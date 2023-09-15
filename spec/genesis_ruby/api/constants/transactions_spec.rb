RSpec.describe GenesisRuby::Api::Constants::Transactions do
  it 'includes common constants mixin' do
    expect(described_class.singleton_class.include?(GenesisRuby::Api::Mixins::Constants::Common)).to eq(true)
  end
end
