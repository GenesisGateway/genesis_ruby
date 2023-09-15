require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/version2/purchase_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Purchase  do
  let(:purchase) do
    GenesisSpec::Stubs::Api::Requests::Financial::Threeds::Version2::PurchaseStub.new
  end

  describe 'when threeds_v2_purchase_category' do
    it 'with valid category' do
      purchase.threeds_v2_purchase_category = category = 'goods'

      expect(purchase.threeds_v2_purchase_category).to eq(category)
    end

    it 'with empty category' do
      purchase.threeds_v2_purchase_category = ''

      expect(purchase.threeds_v2_purchase_category).to eq(nil)
    end

    it 'with invalid category' do
      expect do
        purchase.threeds_v2_purchase_category = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  it 'has request structure' do
    expect(purchase.purchase_attributes).to_not be_empty
  end

end
