RSpec.shared_examples 'digital asset type attributes examples' do
  describe 'when digital asset type attributes' do
    it 'without digital_asset_type' do
      expect(request.build_document).to_not include 'digital_asset_type'
    end

    it 'with digital_asset_type' do
      request.digital_asset_type = value =
        GenesisRuby::Api::Constants::Transactions::Parameters::DigitalAssetTypes.all.sample

      expect(request.build_document).to include "<digital_asset_type>#{value}</digital_asset_type>"
    end
  end
end
