# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/financial/threeds/version2/wpf_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::WpfAttributes  do
  let(:attributes) do
    GenesisSpec::Stubs::Api::Requests::Financial::Threeds::Version2::WpfAttributesStub.new
  end

  it 'has control attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Control
      )
    ).to eq(true)
  end

  it 'raises no method with control device_type' do
    expect { attributes.threeds_v2_control_device_type = 'browser' }.to raise_error NoMethodError
  end

  it 'has purchase attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Purchase
      )
    ).to eq(true)
  end

  it 'has recurring attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::Recurring
      )
    ).to eq(true)
  end

  it 'has merchant_risk attributes' do
    expect(
      described_class.include?(
        GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::MerchantRisk
      )
    ).to eq(true)
  end

  it 'has request structure' do
    expect(attributes.threeds_v2_wpf_attributes_structure).to_not be_empty
  end

  it 'with field values structure' do
    expect(attributes.threeds_field_validations).to_not be_empty
  end

  it 'with field values structure without control device type' do
    expect(attributes.threeds_field_validations).to_not include 'threeds_v2_control_device_type'
  end
end
