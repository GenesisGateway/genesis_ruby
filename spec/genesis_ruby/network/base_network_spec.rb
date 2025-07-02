# frozen_string_literal: true

RSpec.describe GenesisRuby::Network::BaseNetwork do
  let(:configuration) { GenesisRuby::Configuration.new }

  describe 'without implementation' do
    it 'factory raise error' do
      expect { described_class.new(configuration) }.to raise_error(NotImplementedError)
    end
  end
end
