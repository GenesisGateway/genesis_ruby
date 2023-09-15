RSpec.shared_examples 'types examples' do
  it 'includes transaction mixin' do
    expect(described_class.singleton_class.include?(GenesisRuby::Api::Constants::Transactions)).to eq(true)
  end

  it 'has defined transaction types' do
    expect(described_class.all).to be_kind_of(Array)
  end
end
