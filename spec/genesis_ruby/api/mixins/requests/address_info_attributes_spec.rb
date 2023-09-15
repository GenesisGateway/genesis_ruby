require 'spec/genesis_ruby/stubs/api/requests/address_info_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::AddressInfoAttributes do
  let(:address_info_attributes) { GenesisSpec::Stubs::Api::Requests::AddressInfoAttributesStub }

  it 'has customer info attributes' do
    expect(
      address_info_attributes.include?(GenesisRuby::Api::Mixins::Requests::CustomerAddress::CustomerInfoAttributes)
    ).to eq(true)
  end

  it 'has billing info attributes' do
    expect(
      address_info_attributes.include?(GenesisRuby::Api::Mixins::Requests::CustomerAddress::BillingInfoAttributes)
    ).to eq(true)
  end

  it 'has shipping info attributes' do
    expect(
      address_info_attributes.include?(GenesisRuby::Api::Mixins::Requests::CustomerAddress::ShippingInfoAttributes)
    ).to eq(true)
  end
end
