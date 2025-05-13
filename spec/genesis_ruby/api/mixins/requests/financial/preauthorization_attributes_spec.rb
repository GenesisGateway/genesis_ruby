require 'spec/genesis_ruby/stubs/api/requests/financial/preauthorization_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::PreauthorizationAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::PreauthorizationAttributesStub.new }

  describe 'when preauthorization accessors' do
    it 'with setter' do
      expect { attributes.preauthorization = true }.to_not raise_error
    end

    it 'with getter' do
      attributes.preauthorization = true

      expect(attributes.preauthorization).to eq true
    end
  end
end
