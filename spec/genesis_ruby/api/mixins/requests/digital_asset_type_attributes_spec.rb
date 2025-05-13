require 'spec/genesis_ruby/stubs/api/requests/digital_asset_type_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::DigitalAssetTypeAttributes do
  let(:attributes) { GenesisSpec::Stubs::Api::Requests::Financial::DigitalAssetTypeAttributesStub.new }
  let(:digital_asset_type) { GenesisRuby::Api::Constants::Transactions::Parameters::DigitalAssetTypes.all.sample }

  describe 'when digital_asset_type' do
    it 'with setter' do
      expect { attributes.digital_asset_type = digital_asset_type }.to_not raise_error
    end

    it 'with getter' do
      attributes.digital_asset_type = digital_asset_type

      expect(attributes.digital_asset_type).to eq digital_asset_type
    end

    it 'with invalid value' do
      expect { attributes.digital_asset_type = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end
end
