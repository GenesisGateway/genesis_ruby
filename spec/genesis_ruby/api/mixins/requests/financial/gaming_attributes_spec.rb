require 'spec/genesis_ruby/stubs/api/requests/financial/gaming_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::GamingAttributes do
  let(:gaming) { GenesisSpec::Stubs::Api::Requests::Financial::GamingAttributesStub.new }

  describe 'when valid values' do
    it 'with setter' do
      expect { gaming.gaming = true }.to_not raise_error
    end

    it 'with getter' do
      gaming.gaming = true

      expect(gaming.gaming).to eq true
    end
  end

  describe 'when invalid values' do
    it 'with setter' do
      expect { gaming.gaming = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
