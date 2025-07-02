# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/kyc_shipping_info_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::KycShippingInfoAttributes do
  let(:kyc_shipping_info) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::KycShippingInfoAttributesStub.new
  end

  let(:shipping_attributes) do
    {
      first_name: Faker::Name.first_name,
      last_name:  Faker::Name.last_name,
      email:      Faker::Internet.email,
      address1:   Faker::Address.street_address,
      address2:   Faker::Address.secondary_address,
      city:       Faker::Address.city,
      province:   Faker::Address.state,
      zip_code:   Faker::Address.zip_code,
      country:    GenesisRuby::Utils::Country::COUNTRIES.keys.sample,
      phone:      '12345678'
    }
  end

  describe 'shipping info structure' do
    it 'returns a hash with the expected keys and values' do # rubocop:disable RSpec/ExampleLength
      kyc_shipping_info.shipping_first_name     = shipping_attributes[:first_name]
      kyc_shipping_info.shipping_last_name      = shipping_attributes[:last_name]
      kyc_shipping_info.shipping_customer_email = shipping_attributes[:email]
      kyc_shipping_info.shipping_address1       = shipping_attributes[:address1]
      kyc_shipping_info.shipping_address2       = shipping_attributes[:address2]
      kyc_shipping_info.shipping_city           = shipping_attributes[:city]
      kyc_shipping_info.shipping_province       = shipping_attributes[:province]
      kyc_shipping_info.shipping_zip_code       = shipping_attributes[:zip_code]
      kyc_shipping_info.shipping_country        = shipping_attributes[:country]
      kyc_shipping_info.shipping_phone1         = shipping_attributes[:phone]

      expected_hash = {
        first_name:     shipping_attributes[:first_name],
        last_name:      shipping_attributes[:last_name],
        customer_email: shipping_attributes[:email],
        address1:       shipping_attributes[:address1],
        address2:       shipping_attributes[:address2],
        city:           shipping_attributes[:city],
        province:       shipping_attributes[:province],
        zip_code:       shipping_attributes[:zip_code],
        country:        shipping_attributes[:country],
        phone1:         shipping_attributes[:phone]
      }

      structure = kyc_shipping_info.public_send(:kyc_shipping_info_structure)
      expect(structure).to eq(expected_hash)
    end
  end
end
