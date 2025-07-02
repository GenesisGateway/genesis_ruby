# frozen_string_literal: true

RSpec.describe GenesisRuby::Connection do
  let(:configuration) { GenesisRuby::Configuration.new }

  it 'initialize Network' do
    expect(described_class.for(configuration)).to be_a GenesisRuby::Network::NetHttp
  end

  it 'fail with invalid interface' do
    configuration.interface = 'invalid'

    expect { described_class.for(configuration) }.to raise_error(GenesisRuby::NetworkError)
  end
end
