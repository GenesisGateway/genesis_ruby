require 'spec/genesis_ruby/stubs/utils/formatters/response/definitions_stub'

RSpec.describe 'GenesisRuby::Utils::Formatters::Response::Definitions' do
  let(:definitions) { GenesisSpec::Stubs::Utils::Formatters::Response::DefinitionsStub.new }

  it 'has defined formatters' do
    expect(definitions.available_formatters).to eq([
                                                     GenesisRuby::Utils::Formatters::Response::Formats::Amount,
                                                     GenesisRuby::Utils::Formatters::Response::Formats::Timestamp
                                                   ])
  end
end
