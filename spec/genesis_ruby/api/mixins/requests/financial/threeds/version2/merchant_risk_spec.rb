require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/version2/merchant_risk_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::MerchantRisk do
  let(:merchant_risk) do
    GenesisSpec::Stubs::Api::Requests::Financial::Threeds::Version2::MerchantRiskStub.new
  end

  describe 'when threeds_v2_merchant_risk_shipping_indicator' do
    it 'with setter' do
      expect { merchant_risk.threeds_v2_merchant_risk_shipping_indicator = Faker::Lorem.word }.to_not raise_error
    end

    it 'with getter' do
      merchant_risk.threeds_v2_merchant_risk_shipping_indicator = indicator = 'same_as_billing'

      expect(merchant_risk.threeds_v2_merchant_risk_shipping_indicator).to eq indicator
    end

    it 'with empty indicator' do
      merchant_risk.threeds_v2_merchant_risk_shipping_indicator = ''

      expect(merchant_risk.threeds_v2_merchant_risk_shipping_indicator).to eq ''
    end
  end

  describe 'when threeds_v2_merchant_risk_delivery_timeframe' do
    it 'with setter' do
      expect { merchant_risk.threeds_v2_merchant_risk_delivery_timeframe = Faker::Lorem.word }.to_not raise_error
    end

    it 'with getter' do
      merchant_risk.threeds_v2_merchant_risk_delivery_timeframe = timeframe = 'electronic'

      expect(merchant_risk.threeds_v2_merchant_risk_delivery_timeframe).to eq timeframe
    end

    it 'with empty timeframe' do
      merchant_risk.threeds_v2_merchant_risk_delivery_timeframe = ''

      expect(merchant_risk.threeds_v2_merchant_risk_delivery_timeframe).to eq ''
    end
  end

  describe 'when threeds_v2_merchant_risk_reorder_items_indicator' do
    it 'with setter' do
      expect { merchant_risk.threeds_v2_merchant_risk_reorder_items_indicator = Faker::Lorem.word }.to_not raise_error
    end

    it 'with getter' do
      merchant_risk.threeds_v2_merchant_risk_reorder_items_indicator = indicator = 'first_time'

      expect(merchant_risk.threeds_v2_merchant_risk_reorder_items_indicator).to eq indicator
    end

    it 'with empty indicator' do
      merchant_risk.threeds_v2_merchant_risk_reorder_items_indicator = ''

      expect(merchant_risk.threeds_v2_merchant_risk_reorder_items_indicator).to eq ''
    end
  end

  describe 'when threeds_v2_merchant_risk_pre_order_purchase_indicator' do
    it 'with setter' do
      expect { merchant_risk.threeds_v2_merchant_risk_pre_order_purchase_indicator = Faker::Lorem.word }
        .to_not raise_error
    end

    it 'with getter' do
      merchant_risk.threeds_v2_merchant_risk_pre_order_purchase_indicator = indicator = 'merchandise_available'

      expect(merchant_risk.threeds_v2_merchant_risk_pre_order_purchase_indicator).to eq indicator
    end

    it 'with empty indicator' do
      merchant_risk.threeds_v2_merchant_risk_pre_order_purchase_indicator = ''

      expect(merchant_risk.threeds_v2_merchant_risk_pre_order_purchase_indicator).to eq ''
    end
  end

  describe 'when threeds_v2_merchant_risk_pre_order_date' do
    it 'with getter' do
      expect(merchant_risk.threeds_v2_merchant_risk_pre_order_date).to eq nil
    end

    it 'with empty date' do
      merchant_risk.threeds_v2_merchant_risk_pre_order_date = Faker::Date.in_date_period.strftime '%Y-%m-%d'
      merchant_risk.threeds_v2_merchant_risk_pre_order_date = ''

      expect(merchant_risk.threeds_v2_merchant_risk_pre_order_date).to eq nil
    end

    it 'with valid date' do
      date                                                  = Faker::Date.in_date_period
      merchant_risk.threeds_v2_merchant_risk_pre_order_date = date.strftime '%Y-%m-%d'

      expect(merchant_risk.threeds_v2_merchant_risk_pre_order_date).to eq date.strftime('%d-%m-%Y')
    end

    it 'with invalid date' do
      expect do
        merchant_risk.threeds_v2_merchant_risk_pre_order_date = 'invalid'
      end.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when threeds_v2_merchant_risk_gift_card' do
    it 'with setter' do
      expect { merchant_risk.threeds_v2_merchant_risk_gift_card = Faker::Lorem.word }.to_not raise_error
    end

    it 'with getter' do
      merchant_risk.threeds_v2_merchant_risk_gift_card = flag = true

      expect(merchant_risk.threeds_v2_merchant_risk_gift_card).to eq flag
    end

    it 'with empty flag' do
      merchant_risk.threeds_v2_merchant_risk_gift_card = ''

      expect(merchant_risk.threeds_v2_merchant_risk_gift_card).to eq ''
    end
  end

  describe 'when threeds_v2_merchant_risk_gift_card_count' do
    it 'with integer count' do
      merchant_risk.threeds_v2_merchant_risk_gift_card_count = count = 2

      expect(merchant_risk.threeds_v2_merchant_risk_gift_card_count).to eq count
    end

    it 'with string count' do
      merchant_risk.threeds_v2_merchant_risk_gift_card_count = count = '2'

      expect(merchant_risk.threeds_v2_merchant_risk_gift_card_count).to eq count.to_i
    end

    it 'with empty count' do
      merchant_risk.threeds_v2_merchant_risk_gift_card_count = ''

      expect(merchant_risk.threeds_v2_merchant_risk_gift_card_count).to eq nil
    end
  end

  it 'has request structure' do
    expect(merchant_risk.merchant_risk_attributes).to_not be_empty
  end

  it 'with merchant risk field validations structure' do
    expect(merchant_risk.threeds_merchant_risk_field_validations).to_not be_empty
  end

end
