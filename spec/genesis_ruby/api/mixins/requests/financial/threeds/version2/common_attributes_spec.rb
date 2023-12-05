require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/version2/common_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::CommonAttributes  do
  let(:attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::Threeds::Version2::CommonAttributesStub.new
  end

  it 'has method attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Method
      )
    ).to eq true
  end

  it 'has control attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Control
      )
    ).to eq true
  end

  it 'has purchase attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Purchase
      )
    ).to eq true
  end

  it 'has recurring attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Recurring
      )
    ).to eq true
  end

  it 'has merchant_risk attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::MerchantRisk
      )
    ).to eq true
  end

  it 'has browser attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Browser
      )
    ).to eq true
  end

  it 'has sdk attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Sdk
      )
    ).to eq true
  end

  it 'has request structure' do
    expect(attributes.threeds_v2_common_attributes_structure).to_not be_empty
  end

  it 'with threeds_method attributes key' do
    expect(attributes.threeds_v2_common_attributes_structure).to include :threeds_method
  end

  it 'with control attributes key' do
    expect(attributes.threeds_v2_common_attributes_structure).to include :control
  end

  it 'with purchase attributes key' do
    expect(attributes.threeds_v2_common_attributes_structure).to include :purchase
  end

  it 'with merchant_risk attributes key' do
    expect(attributes.threeds_v2_common_attributes_structure).to include :merchant_risk
  end

  it 'with card_holder_account attributes key' do
    expect(attributes.threeds_v2_common_attributes_structure).to include :card_holder_account
  end

  it 'with recurring attributes key' do
    expect(attributes.threeds_v2_common_attributes_structure).to include :recurring
  end

  it 'with browser attributes key' do
    expect(attributes.threeds_v2_common_attributes_structure).to include :browser
  end

  it 'with sdk attributes key' do
    expect(attributes.threeds_v2_common_attributes_structure).to include :sdk
  end
end
