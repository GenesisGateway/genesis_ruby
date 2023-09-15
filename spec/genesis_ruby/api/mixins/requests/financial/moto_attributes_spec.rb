require 'spec/genesis_ruby/stubs/api/requests/financial/moto_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::MotoAttributes do
  let(:moto) { GenesisSpec::Stubs::Api::Requests::Financial::MotoAttributesStub.new }

  describe 'when valid values' do
    it 'with setter' do
      expect { moto.moto = true }.to_not raise_error
    end

    it 'with getter' do
      moto.moto = true

      expect(moto.moto).to eq true
    end
  end

  describe 'when invalid values' do
    it 'with setter' do
      expect { moto.moto = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
