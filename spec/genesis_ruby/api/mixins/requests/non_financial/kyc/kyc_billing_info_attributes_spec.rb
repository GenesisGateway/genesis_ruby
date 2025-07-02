# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/non_financial/kyc/kyc_billing_info_attributes_stub'

RSpec.describe GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::KycBillingInfoAttributes do
  let(:kyc_billing_info) do
    GenesisSpec::Stubs::Api::Requests::NonFinancial::Kyc::KycBillingInfoAttributesStub.new
  end

  let(:billing_attributes) do
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
      phone:      '12345678',
      birth_date: Faker::Date.birthday.to_s,
      gender:     GenesisRuby::Api::Constants::NonFinancial::Kyc::Genders.all.sample
    }
  end

  describe 'billing info structure' do
    it 'returns a hash with the expected keys and values' do # rubocop:disable RSpec/ExampleLength
      kyc_billing_info.billing_first_name     = billing_attributes[:first_name]
      kyc_billing_info.billing_last_name      = billing_attributes[:last_name]
      kyc_billing_info.billing_customer_email = billing_attributes[:email]
      kyc_billing_info.billing_address1       = billing_attributes[:address1]
      kyc_billing_info.billing_address2       = billing_attributes[:address2]
      kyc_billing_info.billing_city           = billing_attributes[:city]
      kyc_billing_info.billing_province       = billing_attributes[:province]
      kyc_billing_info.billing_zip_code       = billing_attributes[:zip_code]
      kyc_billing_info.billing_country        = billing_attributes[:country]
      kyc_billing_info.billing_phone1         = billing_attributes[:phone]
      kyc_billing_info.billing_birth_date     = billing_attributes[:birth_date]
      kyc_billing_info.billing_gender         = billing_attributes[:gender]

      expected_hash = {
        first_name:     billing_attributes[:first_name],
        last_name:      billing_attributes[:last_name],
        customer_email: billing_attributes[:email],
        address1:       billing_attributes[:address1],
        address2:       billing_attributes[:address2],
        city:           billing_attributes[:city],
        province:       billing_attributes[:province],
        zip_code:       billing_attributes[:zip_code],
        country:        billing_attributes[:country],
        phone1:         billing_attributes[:phone],
        birth_date:     billing_attributes[:birth_date],
        gender:         billing_attributes[:gender]
      }

      structure = kyc_billing_info.public_send(:kyc_billing_info_structure)
      expect(structure).to eq(expected_hash)
    end
  end
end
