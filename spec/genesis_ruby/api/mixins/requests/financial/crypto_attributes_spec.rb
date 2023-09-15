require 'spec/genesis_ruby/stubs/api/requests/financial/crypto_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::CryptoAttributes do
  let(:crypto) { GenesisSpec::Stubs::Api::Requests::Financial::CryptoAttributesStub.new }

  describe 'when valid values' do
    it 'with setter' do
      expect { crypto.crypto = true }.to_not raise_error
    end

    it 'with getter' do
      crypto.crypto = true

      expect(crypto.crypto).to eq true
    end
  end

  describe 'when invalid values' do
    it 'with setter' do
      expect { crypto.crypto = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
