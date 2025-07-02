# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/version2/purchase_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Purchase  do
  let(:purchase) do
    GenesisSpec::Stubs::Api::Requests::Financial::Threeds::Version2::PurchaseStub.new
  end

  describe 'when threeds_v2_purchase_category' do
    it 'with setter' do
      expect { purchase.threeds_v2_purchase_category = Faker::Lorem.word }.to_not raise_error
    end

    it 'with getter' do
      purchase.threeds_v2_purchase_category = category = 'goods'

      expect(purchase.threeds_v2_purchase_category).to eq category
    end

    it 'with empty category' do
      purchase.threeds_v2_purchase_category = ''

      expect(purchase.threeds_v2_purchase_category).to eq ''
    end
  end

  it 'has request structure' do
    expect(purchase.purchase_attributes).to_not be_empty
  end

  it 'with threeds purchase field validations' do
    expect(purchase.threeds_purchase_field_validations).to_not be_empty
  end
end
